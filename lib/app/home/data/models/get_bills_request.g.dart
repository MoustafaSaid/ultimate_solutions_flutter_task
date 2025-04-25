// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bills_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillsRequest _$GetBillsRequestFromJson(Map<String, dynamic> json) =>
    GetBillsRequest(
      value: Value.fromJson(json['Value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBillsRequestToJson(GetBillsRequest instance) =>
    <String, dynamic>{
      'Value': instance.value.toJson(),
    };

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      deliveryNo: json['P_DLVRY_NO'] as String,
      langNo: json['P_LANG_NO'] as String,
      billSerial: json['P_BILL_SRL'] as String? ?? "",
      processedFlag: json['P_PRCSSD_FLG'] as String? ?? "",
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'P_DLVRY_NO': instance.deliveryNo,
      'P_LANG_NO': instance.langNo,
      'P_BILL_SRL': instance.billSerial,
      'P_PRCSSD_FLG': instance.processedFlag,
    };
