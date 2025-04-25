import 'package:dartz/dartz.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/entities/login_entity.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login({
    required String deliveryNo,
    required String password,
    String languageNo,
  });
}
