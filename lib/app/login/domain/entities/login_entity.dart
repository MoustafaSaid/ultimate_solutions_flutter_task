import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String deliveryName;
  final bool isSuccess;
  final String message;

  const LoginEntity({
    required this.deliveryName,
    required this.isSuccess,
    required this.message,
  });

  @override
  List<Object?> get props => [deliveryName, isSuccess, message];

  LoginEntity copyWith({
    String? deliveryName,
    bool? isSuccess,
    String? message,
  }) {
    return LoginEntity(
      deliveryName: deliveryName ?? this.deliveryName,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }
}
