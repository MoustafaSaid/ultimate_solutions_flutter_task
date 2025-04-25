import 'package:dartz/dartz.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/bill_entity.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/repositories/bill_repository.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

class GetBillsUseCase {
  final BillRepository repository;

  GetBillsUseCase(this.repository);

  Future<Either<Failure, List<BillEntity>>> call(
      {required String deliveryNo,
      required String langNo,
      String billSerial = "",
      String processedFlag = ""}) async {
    // Try to get bills from API
    final result = await repository.getBills(
      deliveryNo: deliveryNo,
      langNo: langNo,
      billSerial: billSerial,
      processedFlag: processedFlag,
    );

    return result.fold(
      (failure) async {
        // If API fails, try to get cached bills
        final cachedBills = await repository.getCachedBills();
        return cachedBills;
      },
      (bills) async {
        // Cache the bills from API
        await repository.cacheBills(bills);
        return Right(bills);
      },
    );
  }
}
