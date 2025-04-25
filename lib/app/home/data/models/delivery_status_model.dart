import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/delivery_status_entity.dart';

part 'delivery_status_model.g.dart';

@JsonSerializable()
class DeliveryStatusModel extends Equatable {
  @JsonKey(name: 'TYP_NO')
  final String? typeNo;

  @JsonKey(name: 'TYP_NM')
  final String? typeName;

  const DeliveryStatusModel({
    this.typeNo,
    this.typeName,
  });

  factory DeliveryStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryStatusModelToJson(this);

  factory DeliveryStatusModel.fromEntity(DeliveryStatusEntity entity) {
    return DeliveryStatusModel(
      typeNo: entity.typeNo,
      typeName: entity.typeName,
    );
  }

  DeliveryStatusEntity toEntity() {
    return DeliveryStatusEntity(
      typeNo: typeNo ?? '',
      typeName: typeName ?? '',
    );
  }

  @override
  List<Object?> get props => [typeNo, typeName];
}
