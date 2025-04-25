import 'package:dartz/dartz.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/delivery_status_entity.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

abstract class DeliveryStatusRepository {
  Future<Either<Failure, List<DeliveryStatusEntity>>> getDeliveryStatuses({
    required String langNo,
  });

  Future<Either<Failure, List<DeliveryStatusEntity>>>
      getCachedDeliveryStatuses();

  Future<Either<Failure, void>> cacheDeliveryStatuses(
      List<DeliveryStatusEntity> statuses);
}
