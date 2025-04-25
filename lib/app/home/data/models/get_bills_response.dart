import 'package:json_annotation/json_annotation.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/bill_model.dart';

part 'get_bills_response.g.dart';

@JsonSerializable()
class GetBillsResponse {
  @JsonKey(name: 'Data')

  final Data? data;
  @JsonKey(name: 'Result')

  final Result? result;

  GetBillsResponse({this.data, this.result});

  factory GetBillsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBillsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillsResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'DeliveryBills')
  final List<BillModel>? deliveryBills;

  Data({this.deliveryBills});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'ErrNo')
  final int? errorNo;

  @JsonKey(name: 'ErrMsg')
  final String? errorMsg;

  Result({this.errorNo, this.errorMsg});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
