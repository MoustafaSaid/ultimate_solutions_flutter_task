// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bills_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillsResponse _$GetBillsResponseFromJson(Map<String, dynamic> json) =>
    GetBillsResponse(
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
      result: json['Result'] == null
          ? null
          : Result.fromJson(json['Result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBillsResponseToJson(GetBillsResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'Result': instance.result,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      deliveryBills: (json['DeliveryBills'] as List<dynamic>?)
          ?.map((e) => BillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'DeliveryBills': instance.deliveryBills,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      errorNo: (json['ErrNo'] as num?)?.toInt(),
      errorMsg: json['ErrMsg'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'ErrNo': instance.errorNo,
      'ErrMsg': instance.errorMsg,
    };
