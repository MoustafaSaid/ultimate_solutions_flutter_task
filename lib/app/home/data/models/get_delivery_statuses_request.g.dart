// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_delivery_statuses_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDeliveryStatusesRequest _$GetDeliveryStatusesRequestFromJson(
        Map<String, dynamic> json) =>
    GetDeliveryStatusesRequest(
      value: Value.fromJson(json['Value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDeliveryStatusesRequestToJson(
        GetDeliveryStatusesRequest instance) =>
    <String, dynamic>{
      'Value': instance.value,
    };

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      langNo: json['P_LANG_NO'] as String,
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'P_LANG_NO': instance.langNo,
    };
