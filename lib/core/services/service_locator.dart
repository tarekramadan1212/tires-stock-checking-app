import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/business_logic/stock_cubit/stock_cubit.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import 'package:supreme/data/authentication/auth_data_source/base_auth_data_source.dart';
import 'package:supreme/data/authentication/auth_repo/auth_repo_impl.dart';
import 'package:supreme/data/authentication/auth_repo/base_auth_repo.dart';
import 'package:supreme/data/customers/customers_datasource/customers_datasource_impl.dart';
import 'package:supreme/data/customers/customers_repository/i_customers_repository.dart';
import 'package:supreme/data/tires/stock_datasource/i_stock_datasource.dart';
import 'package:supreme/data/tires/stock_datasource/stock_datasource_impl.dart';
import 'package:supreme/data/tires/stock_repository/i_stock_repository.dart';
import 'package:supreme/data/tires/stock_repository/stock_repository_impl.dart';

import '../../business_logic/auth_bloc/auth_bloc.dart';
import '../../data/authentication/auth_data_source/auth_data_source_impl.dart';
import '../../data/customers/customers_datasource/I_customers_datasource.dart';
import '../../data/customers/customers_repository/customers_repository_impl.dart';

final sl = GetIt.instance;

Future<void> setUpServiceLocator()async
{

  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  ///Auth Services
  sl.registerLazySingleton<BaseAuthDataSource>(() => AuthDataSourceImpl(client: sl()));

  sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepositoryImpl(authDataSource: sl()));

  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(authRepository: sl<BaseAuthRepository>()));

  ///Waiting List Services
  sl.registerLazySingleton<ICustomersDatasource>(() => CustomersDatasourceImpl(client: sl()));

  sl.registerLazySingleton<ICustomersRepo>(() => CustomersRepositoryImpl(datasource: sl()));

  sl.registerLazySingleton<WaitingListCubit>(() => WaitingListCubit(repository: sl()));

  ///Stock Services
  sl.registerLazySingleton<BaseTiresDataSource>(()=>TiresDataImpl());
  sl.registerLazySingleton<BaseTiresRepository>(()=>TiresRepositoryImpl(dataSource: sl<BaseTiresDataSource>()));
  sl.registerLazySingleton<StockCubit>(()=>StockCubit(repository: sl<BaseTiresRepository>()));

}