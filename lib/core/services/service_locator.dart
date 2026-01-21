import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/data/authentication/auth_data_source/base_auth_data_source.dart';
import 'package:supreme/data/authentication/auth_repo/auth_repo_impl.dart';
import 'package:supreme/data/authentication/auth_repo/base_auth_repo.dart';

import '../../business_logic/auth_bloc/auth_bloc.dart';
import '../../data/authentication/auth_data_source/auth_data_source_impl.dart';

final sl = GetIt.instance;

Future<void> setUpServiceLocator()async
{
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  
  sl.registerLazySingleton<BaseAuthDataSource>(() => AuthDataSourceImpl(client: sl()));

  sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepositoryImpl(authDataSource: sl()));

  sl.registerFactory(() => AuthBloc(authRepository: sl<BaseAuthRepository>()));

}