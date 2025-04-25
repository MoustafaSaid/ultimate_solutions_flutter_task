import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/bill_entity.dart';

part 'bill_model.g.dart';

@JsonSerializable()
class BillModel extends Equatable {
  @JsonKey(name: 'BILL_TYPE')
  final String? billType;

  @JsonKey(name: 'BILL_NO')
  final String? billNo;

  @JsonKey(name: 'BILL_SRL')
  final String? billSerial;

  @JsonKey(name: 'BILL_DATE')
  final String? billDate;

  @JsonKey(name: 'BILL_TIME')
  final String? billTime;

  @JsonKey(name: 'BILL_AMT')
  final String? billAmount;

  @JsonKey(name: 'TAX_AMT')
  final String? taxAmount;

  @JsonKey(name: 'DLVRY_AMT')
  final String? deliveryAmount;

  @JsonKey(name: 'MOBILE_NO')
  final String? mobileNo;

  @JsonKey(name: 'CSTMR_NM')
  final String? customerName;

  @JsonKey(name: 'RGN_NM')
  final String? regionName;

  @JsonKey(name: 'CSTMR_BUILD_NO')
  final String? buildingNo;

  @JsonKey(name: 'CSTMR_FLOOR_NO')
  final String? floorNo;

  @JsonKey(name: 'CSTMR_APRTMNT_NO')
  final String? apartmentNo;

  @JsonKey(name: 'CSTMR_ADDRSS')
  final String? address;

  @JsonKey(name: 'LATITUDE')
  final String? latitude;

  @JsonKey(name: 'LONGITUDE')
  final String? longitude;

  @JsonKey(name: 'DLVRY_STATUS_FLG')
  final String? deliveryStatusFlag;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? deliveryStatusName;

  const BillModel({
    this.billType,
    this.billNo,
    this.billSerial,
    this.billDate,
    this.billTime,
    this.billAmount,
    this.taxAmount,
    this.deliveryAmount,
    this.mobileNo,
    this.customerName,
    this.regionName,
    this.buildingNo,
    this.floorNo,
    this.apartmentNo,
    this.address,
    this.latitude,
    this.longitude,
    this.deliveryStatusFlag,
    this.deliveryStatusName,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) =>
      _$BillModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillModelToJson(this);

  factory BillModel.fromEntity(BillEntity entity) {
    return BillModel(
      billType: entity.billType,
      billNo: entity.billNo,
      billSerial: entity.billSerial,
      billDate: entity.billDate,
      billTime: entity.billTime,
      billAmount: entity.billAmount,
      taxAmount: entity.taxAmount,
      deliveryAmount: entity.deliveryAmount,
      mobileNo: entity.mobileNo,
      customerName: entity.customerName,
      regionName: entity.regionName,
      buildingNo: entity.buildingNo,
      floorNo: entity.floorNo,
      apartmentNo: entity.apartmentNo,
      address: entity.address,
      latitude: entity.latitude,
      longitude: entity.longitude,
      deliveryStatusFlag: entity.deliveryStatusFlag,
      deliveryStatusName: entity.deliveryStatusName,
    );
  }

  BillEntity toEntity() {
    return BillEntity(
      billType: billType ?? '',
      billNo: billNo ?? '',
      billSerial: billSerial ?? '',
      billDate: billDate ?? '',
      billTime: billTime ?? '',
      billAmount: billAmount ?? '',
      taxAmount: taxAmount ?? '',
      deliveryAmount: deliveryAmount ?? '',
      mobileNo: mobileNo ?? '',
      customerName: customerName ?? '',
      regionName: regionName ?? '',
      buildingNo: buildingNo ?? '',
      floorNo: floorNo ?? '',
      apartmentNo: apartmentNo ?? '',
      address: address ?? '',
      latitude: latitude ?? '',
      longitude: longitude ?? '',
      deliveryStatusFlag: deliveryStatusFlag ?? '',
      deliveryStatusName: deliveryStatusName,
    );
  }

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
