
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/datasources/login_api_client.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/models/login_request_model.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/entities/login_entity.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/repositories/login_repository.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApiClient remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String deliveryNo,
    required String password,
    String languageNo = "2",
  }) async {
    try {
      final result = await remoteDataSource.login(LoginRequestModel(
          value: LoginRequestValue(
              languageNo: languageNo,
              deliveryNo: deliveryNo,
              password: password)));

      // Map response model to entity
      try {
        final loginEntity = LoginEntity(
          deliveryName: result.data.deliveryName ?? '',
          isSuccess: result.result.isSuccess,
          message: result.result.errorMessage,
        );
        return Right(loginEntity);
      } catch (e) {
        // Handle null or invalid values in response
        return Left(
            ServerFailure(message: 'Invalid response format: ${e.toString()}'));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(ConnectionFailure(
            message: 'Connection timeout. Please try again.'));
      }

      return Left(ServerFailure(
          message: e.response?.data?['Result']?['ErrMsg'] ??
              'Server error. Please try again.'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
