// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    LoginRequestModel(
      value: LoginRequestValue.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

LoginRequestValue _$LoginRequestValueFromJson(Map<String, dynamic> json) =>
    LoginRequestValue(
      languageNo: json['P_LANG_NO'] as String,
      deliveryNo: json['P_DLVRY_NO'] as String,
      password: json['P_PSSWRD'] as String,
    );

Map<String, dynamic> _$LoginRequestValueToJson(LoginRequestValue instance) =>
    <String, dynamic>{
      'P_LANG_NO': instance.languageNo,
      'P_DLVRY_NO': instance.deliveryNo,
      'P_PSSWRD': instance.password,
    };
