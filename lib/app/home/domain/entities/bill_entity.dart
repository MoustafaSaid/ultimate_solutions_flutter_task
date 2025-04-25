import 'package:equatable/equatable.dart';

class BillEntity extends Equatable {
  final String billType;
  final String billNo;
  final String billSerial;
  final String billDate;
  final String billTime;
  final String billAmount;
  final String taxAmount;
  final String deliveryAmount;
  final String mobileNo;
  final String customerName;
  final String regionName;
  final String buildingNo;
  final String floorNo;
  final String apartmentNo;
  final String address;
  final String latitude;
  final String longitude;
  final String deliveryStatusFlag;
  final String? deliveryStatusName;

  const BillEntity({
    required this.billType,
    required this.billNo,
    required this.billSerial,
    required this.billDate,
    required this.billTime,
    required this.billAmount,
    required this.taxAmount,
    required this.deliveryAmount,
    required this.mobileNo,
    required this.customerName,
    required this.regionName,
    required this.buildingNo,
    required this.floorNo,
    required this.apartmentNo,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.deliveryStatusFlag,
    this.deliveryStatusName,
  });

  @override
  List<Object?> get props => [
        billType,
        billNo,
        billSerial,
        billDate,
        billTime,
        billAmount,
        taxAmount,
        deliveryAmount,
        mobileNo,
        customerName,
        regionName,
        buildingNo,
        floorNo,
        apartmentNo,
        address,
        latitude,
        longitude,
        deliveryStatusFlag,
        deliveryStatusName,
      ];
}
