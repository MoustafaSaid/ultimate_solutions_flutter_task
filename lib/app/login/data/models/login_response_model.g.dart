// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      data: LoginData.fromJson(json['Data'] as Map<String, dynamic>),
      result: LoginResult.fromJson(json['Result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'Result': instance.result,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      deliveryName: json['DeliveryName'] as String?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'DeliveryName': instance.deliveryName,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      errorNumber: (json['ErrNo'] as num).toInt(),
      errorMessage: json['ErrMsg'] as String? ?? '',
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'ErrNo': instance.errorNumber,
      'ErrMsg': instance.errorMessage,
    };
