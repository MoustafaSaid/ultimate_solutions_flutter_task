import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/datasources/login_api_client.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/repositories/login_repository_impl.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/repositories/login_repository.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => LoginCubit(loginRepository: sl()));

  // Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LoginApiClient>(() => LoginApiClient(sl()),);

  // External
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
