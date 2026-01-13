import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_vault/domain/usecases/auth/sign_in_usecase.dart';
import 'package:quote_vault/domain/usecases/auth/sign_up_usecase.dart';
import 'package:quote_vault/domain/usecases/auth/get_current_session_usecase.dart';
import 'package:quote_vault/domain/repositories/auth/auth_repository.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_event.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUsecase signInUseCase;
  final GetCurrentSessionUseCase getCurrentSessionUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.getCurrentSessionUseCase,
    required this.authRepository,
  }) : super(const AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
    on<CheckSessionEvent>(_onCheckSession);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final params = SignUpParams(
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
      fullName: event.fullName,
    );

    final result = await signUpUseCase(params);

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (session) => emit(AuthAuthenticated(session: session)),
    );
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final params = SignInParams(
      email: event.email,
      password: event.password,
    );

    final result = await signInUseCase(params);

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (session) => emit(AuthAuthenticated(session: session))
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await authRepository.signOut();

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onCheckSession(CheckSessionEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await getCurrentSessionUseCase();

    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (session) {
        if (session != null && !session.isExpired) {
          emit(AuthAuthenticated(session: session));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await authRepository.resetPassword(event.email);

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (_) => emit(const AuthSuccess(message: 'Password reset email sent')),
    );
  }
}