import 'package:equatable/equatable.dart';

class DeliveryStatusEntity extends Equatable {
  final String typeNo;
  final String typeName;

  const DeliveryStatusEntity({
    required this.typeNo,
    required this.typeName,
  });

  @override
  List<Object?> get props => [typeNo, typeName];
}
