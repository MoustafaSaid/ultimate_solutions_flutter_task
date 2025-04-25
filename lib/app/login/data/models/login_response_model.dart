import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'Data')
  final LoginData data;
  @JsonKey(name: 'Result')
  final LoginResult result;

  LoginResponseModel({
    required this.data,
    required this.result,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    // Check if Data is an empty object and handle it
    var dataJson = json['Data'] as Map<String, dynamic>;
    var data = dataJson.isEmpty ? LoginData() : LoginData.fromJson(dataJson);

    return LoginResponseModel(
      data: data,
      result: LoginResult.fromJson(json['Result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class LoginData {
  @JsonKey(name: 'DeliveryName')
  final String? deliveryName;

  LoginData({
    this.deliveryName,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class LoginResult {
  @JsonKey(name: 'ErrNo')
  final int errorNumber;

  @JsonKey(name: 'ErrMsg', defaultValue: '')
  final String errorMessage;

  LoginResult({
    required this.errorNumber,
    required this.errorMessage,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  bool get isSuccess => errorNumber == 0;
}
