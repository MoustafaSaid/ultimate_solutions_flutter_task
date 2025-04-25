import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/datasources/local/home_local_data_source.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/datasources/remote/home_api_service.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/repositories/bill_repository_impl.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/repositories/delivery_status_repository_impl.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/repositories/bill_repository.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/repositories/delivery_status_repository.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/usecases/get_bills_usecase.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/usecases/get_delivery_statuses_usecase.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/cubit/home_cubit.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/datasources/login_api_client.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/repositories/login_repository_impl.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/repositories/login_repository.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_cubit.dart';
import 'package:ultimate_solution_flutter_task/core/utils/session_timeout_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => LoginCubit(loginRepository: sl()));
  sl.registerFactory(() => HomeCubit(
        getBillsUseCase: sl(),
        getDeliveryStatusesUseCase: sl(),
      ));

  // Session Management
  sl.registerLazySingleton(() => SessionTimeoutManager());

  // Use cases
  sl.registerLazySingleton(() => GetBillsUseCase(sl()));
  sl.registerLazySingleton(() => GetDeliveryStatusesUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<BillRepository>(
    () => BillRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );
  sl.registerLazySingleton<DeliveryStatusRepository>(
    () => DeliveryStatusRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginApiClient>(
    () => LoginApiClient(sl()),
  );

  // Initialize database
  final database = await HomeLocalDataSourceImpl.initDatabase();
  sl.registerLazySingleton<Database>(() => database);

  // API Services
  sl.registerLazySingleton<HomeApiService>(() => HomeApiService(sl()));

  // Remote and Local data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiService: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(database: sl()),
  );

  // External
  sl.registerLazySingleton(() => Connectivity());
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://mdev.yemensoft.net:8087',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );

  sl.registerLazySingleton(() => dio);
}
