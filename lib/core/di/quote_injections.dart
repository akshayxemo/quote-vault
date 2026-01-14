import 'package:get_it/get_it.dart';
import 'package:quote_vault/core/network/network_info.dart';
import 'package:quote_vault/data/datasources/quote_remote_datasource.dart';
import 'package:quote_vault/data/repositories/quote_repository_impl.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';
import 'package:quote_vault/domain/usecases/quote/get_categories_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/get_favorite_quotes_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/get_quote_of_the_day_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/get_quotes_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/toggle_favorite_usecase.dart';
import 'package:quote_vault/presentation/bloc/home/home_bloc.dart';
import 'package:quote_vault/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initQuoteInjections() async {
  // Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Data sources
  sl.registerLazySingleton<QuoteRemoteDataSource>(
    () => QuoteRemoteDataSourceImpl(
      supabaseClient: Supabase.instance.client,
    ),
  );

  // Repository
  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetQuoteOfTheDayUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetQuotesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoriteQuotesUseCase(sl()));

  // Blocs
  sl.registerFactory(
    () => HomeBloc(
      getQuoteOfTheDayUseCase: sl(),
      getCategoriesUseCase: sl(),
      getQuotesUseCase: sl(),
      toggleFavoriteUseCase: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerFactory(
    () => FavoritesBloc(
      getFavoriteQuotesUseCase: sl(),
      toggleFavoriteUseCase: sl(),
      networkInfo: sl(),
    ),
  );
}
