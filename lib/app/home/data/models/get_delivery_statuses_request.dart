import 'package:json_annotation/json_annotation.dart';

part 'get_delivery_statuses_request.g.dart';

@JsonSerializable()
class GetDeliveryStatusesRequest {
  @JsonKey(name: 'Value')

  final Value value;

  GetDeliveryStatusesRequest({required this.value});

  factory GetDeliveryStatusesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetDeliveryStatusesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetDeliveryStatusesRequestToJson(this);
}

@JsonSerializable()
class Value {
  @JsonKey(name: 'P_LANG_NO')
  final String langNo;

  Value({
    required this.langNo,
  });

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);
}
