import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import '../../../domain/usecases/get_current_session_usecase.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final GetCurrentSessionUseCase getCurrentSessionUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.signUpUseCase,
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

    final result = await authRepository.signIn(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (session) async {
        // Save session locally
        final saveResult = await authRepository.saveSession(session);
        saveResult.fold(
          (failure) => emit(AuthError(message: failure.message, code: failure.code)),
          (_) => emit(AuthAuthenticated(session: session)),
        );
      },
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
        if (session != null && session.isValid) {
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