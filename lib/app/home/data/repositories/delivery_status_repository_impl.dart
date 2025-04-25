import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/datasources/local/home_local_data_source.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/delivery_status_model.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/delivery_status_entity.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/repositories/delivery_status_repository.dart';
import 'package:ultimate_solution_flutter_task/core/error/exceptions.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

class DeliveryStatusRepositoryImpl implements DeliveryStatusRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final Connectivity connectivity;

  DeliveryStatusRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, List<DeliveryStatusEntity>>> getDeliveryStatuses({
    required String langNo,
  }) async {
    // Check connectivity first
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return Left(ConnectionFailure(message: 'No internet connection'));
    }

    try {
      final statuses =
          await remoteDataSource.getDeliveryStatuses(langNo: langNo);
      return Right(statuses.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DeliveryStatusEntity>>>
      getCachedDeliveryStatuses() async {
    try {
      final statuses = await localDataSource.getCachedDeliveryStatuses();
      return Right(statuses.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheDeliveryStatuses(
      List<DeliveryStatusEntity> statuses) async {
    try {
      final statusModels = statuses
          .map((entity) => DeliveryStatusModel.fromEntity(entity))
          .toList();
      await localDataSource.cacheDeliveryStatuses(statusModels);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
