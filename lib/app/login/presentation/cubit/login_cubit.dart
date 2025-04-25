import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/repositories/login_repository.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit({required this.loginRepository}) : super(const LoginState());

  Future<void> login({
    required String deliveryNo,
    required String password,
    String languageNo = "2",
  }) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await loginRepository.login(
      deliveryNo: deliveryNo,
      password: password,
      languageNo: languageNo,
    );


    result.fold(
      (failure) => emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: failure.message,
      )),
      (login) {
        if (login.isSuccess) {
          emit(state.copyWith(
            status: LoginStatus.success,
            login: login,
          ));
        } else {
          emit(state.copyWith(
            status: LoginStatus.error,
            errorMessage: login.message,
            login: login,
          ));
        }
      },
    );
  }

  void resetState() {
    emit(const LoginState());
  }
}
