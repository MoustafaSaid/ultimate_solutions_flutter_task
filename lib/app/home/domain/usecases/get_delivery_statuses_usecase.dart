import 'package:dartz/dartz.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/delivery_status_entity.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/repositories/delivery_status_repository.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

class GetDeliveryStatusesUseCase {
  final DeliveryStatusRepository repository;

  GetDeliveryStatusesUseCase(this.repository);

  Future<Either<Failure, List<DeliveryStatusEntity>>> call({
    required String langNo,
  }) async {
    // Try to get delivery statuses from API
    final result = await repository.getDeliveryStatuses(langNo: langNo);

    return result.fold(
      (failure) async {
        // If API fails, try to get cached delivery statuses
        final cachedStatuses = await repository.getCachedDeliveryStatuses();
        return cachedStatuses;
      },
      (statuses) async {
        // Cache the delivery statuses from API
        await repository.cacheDeliveryStatuses(statuses);
        return Right(statuses);
      },
    );
  }
}
