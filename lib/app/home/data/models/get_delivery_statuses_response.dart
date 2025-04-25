import 'package:json_annotation/json_annotation.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/delivery_status_model.dart';

part 'get_delivery_statuses_response.g.dart';

@JsonSerializable()
class GetDeliveryStatusesResponse {
  final Data? data;
  final Result? result;

  GetDeliveryStatusesResponse({this.data, this.result});

  factory GetDeliveryStatusesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDeliveryStatusesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDeliveryStatusesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'DeliveryStatusTypes')
  final List<DeliveryStatusModel>? deliveryStatusTypes;

  Data({this.deliveryStatusTypes});

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
