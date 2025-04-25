import 'package:equatable/equatable.dart';
import 'package:ultimate_solution_flutter_task/app/login/domain/entities/login_entity.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginEntity? login;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.login,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, login, errorMessage];

  LoginState copyWith({
    LoginStatus? status,
    LoginEntity? login,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      login: login ?? this.login,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Helper methods for state checking
  bool get isInitial => status == LoginStatus.initial;
  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isError => status == LoginStatus.error;
}
