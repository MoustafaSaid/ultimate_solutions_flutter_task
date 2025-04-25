import 'package:dartz/dartz.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/bill_entity.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

abstract class BillRepository {
  Future<Either<Failure, List<BillEntity>>> getBills(
      {required String deliveryNo,
      required String langNo,
      String billSerial = "",
      String processedFlag = ""});

  Future<Either<Failure, List<BillEntity>>> getCachedBills();

  Future<Either<Failure, void>> cacheBills(List<BillEntity> bills);
}
