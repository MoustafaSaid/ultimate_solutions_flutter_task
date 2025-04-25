// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_delivery_statuses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDeliveryStatusesResponse _$GetDeliveryStatusesResponseFromJson(
        Map<String, dynamic> json) =>
    GetDeliveryStatusesResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDeliveryStatusesResponseToJson(
        GetDeliveryStatusesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'result': instance.result,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      deliveryStatusTypes: (json['DeliveryStatusTypes'] as List<dynamic>?)
          ?.map((e) => DeliveryStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'DeliveryStatusTypes': instance.deliveryStatusTypes,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      errorNo: (json['ErrNo'] as num?)?.toInt(),
      errorMsg: json['ErrMsg'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'ErrNo': instance.errorNo,
      'ErrMsg': instance.errorMsg,
    };
