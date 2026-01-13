import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Domain
import 'package:quote_vault/domain/repositories/auth/auth_repository.dart';
import 'package:quote_vault/domain/usecases/auth/sign_up_usecase.dart';
import 'package:quote_vault/domain/usecases/auth/get_current_session_usecase.dart';

// Data
import 'package:quote_vault/data/repositories/auth_repository_impl.dart';
import 'package:quote_vault/data/datasources/auth/auth_remote_datasource.dart';
import 'package:quote_vault/data/datasources/auth/auth_local_datasource.dart';

// Presentation
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Supabase.instance.client);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: sl()),
  );
  
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentSessionUseCase(sl()));

  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      signUpUseCase: sl(),
      getCurrentSessionUseCase: sl(),
      authRepository: sl(),
    ),
  );
}