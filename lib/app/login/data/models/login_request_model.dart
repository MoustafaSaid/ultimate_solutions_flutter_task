import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  final LoginRequestValue value;

  LoginRequestModel({
    required this.value,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  factory LoginRequestModel.create({
    required String languageNo,
    required String deliveryNo,
    required String password,
  }) {
    return LoginRequestModel(
      value: LoginRequestValue(
        languageNo: languageNo,
        deliveryNo: deliveryNo,
        password: password,
      ),
    );
  }
}

@JsonSerializable()
class LoginRequestValue {
  @JsonKey(name: 'P_LANG_NO')
  final String languageNo;

  @JsonKey(name: 'P_DLVRY_NO')
  final String deliveryNo;

  @JsonKey(name: 'P_PSSWRD')
  final String password;

  LoginRequestValue({
    required this.languageNo,
    required this.deliveryNo,
    required this.password,
  });

  factory LoginRequestValue.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestValueFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestValueToJson(this);
}
