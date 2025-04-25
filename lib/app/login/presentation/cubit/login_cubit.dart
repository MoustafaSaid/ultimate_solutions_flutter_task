import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/repositories/login_repository.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_state.dart';
import 'package:ultimate_solution_flutter_task/core/utils/shared_prefs_utils.dart';
import 'package:flutter/foundation.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit({required this.loginRepository}) : super(const LoginState());

  Future<void> login({
    required String deliveryNo,
    required String password,
    String? languageNo,
  }) async {
    emit(state.copyWith(status: LoginStatus.loading));

    // If languageNo is not provided, get it from SharedPreferences
    // Using '1' for Arabic, '2' for English
    final String actualLanguageNo =
        languageNo ?? (SharedPrefsUtils.getLanguageCode() == 'ar' ? '1' : '2');

    final result = await loginRepository.login(
      deliveryNo: deliveryNo,
      password: password,
      languageNo: actualLanguageNo,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: failure.message,
      )),
      (login) {
        if (login.isSuccess) {
          // Save user data to SharedPreferences
          debugPrint('Login successful, saving user data to SharedPrefs');
          debugPrint(
              'DeliveryNo: $deliveryNo, Username: ${login.deliveryName}');

          SharedPrefsUtils.saveUserData(
            deliveryNo: deliveryNo,
            password: password,
            userName: login.deliveryName,
          );

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
