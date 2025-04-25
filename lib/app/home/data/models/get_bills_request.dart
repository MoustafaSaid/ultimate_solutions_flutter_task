import 'package:json_annotation/json_annotation.dart';

part 'get_bills_request.g.dart';

@JsonSerializable(explicitToJson: true)
class GetBillsRequest {
  @JsonKey(name: 'Value')
  final Value value;

  GetBillsRequest({required this.value});

  factory GetBillsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBillsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillsRequestToJson(this);
}

@JsonSerializable()
class Value {
  @JsonKey(name: 'P_DLVRY_NO')
  final String deliveryNo;

  @JsonKey(name: 'P_LANG_NO')
  final String langNo;

  @JsonKey(name: 'P_BILL_SRL')
  final String billSerial;

  @JsonKey(name: 'P_PRCSSD_FLG')
  final String processedFlag;

  Value({
    required this.deliveryNo,
    required this.langNo,
    this.billSerial = "",
    this.processedFlag = "",
  });

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);
}
