// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillModel _$BillModelFromJson(Map<String, dynamic> json) => BillModel(
      billType: json['BILL_TYPE'] as String?,
      billNo: json['BILL_NO'] as String?,
      billSerial: json['BILL_SRL'] as String?,
      billDate: json['BILL_DATE'] as String?,
      billTime: json['BILL_TIME'] as String?,
      billAmount: json['BILL_AMT'] as String?,
      taxAmount: json['TAX_AMT'] as String?,
      deliveryAmount: json['DLVRY_AMT'] as String?,
      mobileNo: json['MOBILE_NO'] as String?,
      customerName: json['CSTMR_NM'] as String?,
      regionName: json['RGN_NM'] as String?,
      buildingNo: json['CSTMR_BUILD_NO'] as String?,
      floorNo: json['CSTMR_FLOOR_NO'] as String?,
      apartmentNo: json['CSTMR_APRTMNT_NO'] as String?,
      address: json['CSTMR_ADDRSS'] as String?,
      latitude: json['LATITUDE'] as String?,
      longitude: json['LONGITUDE'] as String?,
      deliveryStatusFlag: json['DLVRY_STATUS_FLG'] as String?,
    );

Map<String, dynamic> _$BillModelToJson(BillModel instance) => <String, dynamic>{
      'BILL_TYPE': instance.billType,
      'BILL_NO': instance.billNo,
      'BILL_SRL': instance.billSerial,
      'BILL_DATE': instance.billDate,
      'BILL_TIME': instance.billTime,
      'BILL_AMT': instance.billAmount,
      'TAX_AMT': instance.taxAmount,
      'DLVRY_AMT': instance.deliveryAmount,
      'MOBILE_NO': instance.mobileNo,
      'CSTMR_NM': instance.customerName,
      'RGN_NM': instance.regionName,
      'CSTMR_BUILD_NO': instance.buildingNo,
      'CSTMR_FLOOR_NO': instance.floorNo,
      'CSTMR_APRTMNT_NO': instance.apartmentNo,
      'CSTMR_ADDRSS': instance.address,
      'LATITUDE': instance.latitude,
      'LONGITUDE': instance.longitude,
      'DLVRY_STATUS_FLG': instance.deliveryStatusFlag,
    };
