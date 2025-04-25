import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/datasources/remote/home_api_service.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/bill_model.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/delivery_status_model.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/get_bills_request.dart'
    as bills_request;
import 'package:ultimate_solution_flutter_task/app/home/data/models/get_delivery_statuses_request.dart'
    as status_request;
import 'package:ultimate_solution_flutter_task/core/error/exceptions.dart';

abstract class HomeRemoteDataSource {
  Future<List<BillModel>> getBills(
      {required String deliveryNo,
      required String langNo,
      String billSerial = "",
      String processedFlag = ""});

  Future<List<DeliveryStatusModel>> getDeliveryStatuses({
    required String langNo,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BillModel>> getBills(
      {required String deliveryNo,
      required String langNo,
      String billSerial = "",
      String processedFlag = ""}) async {
    try {
      final request = bills_request.GetBillsRequest(
        value: bills_request.Value(
          deliveryNo: deliveryNo,
          langNo: langNo,
          billSerial: billSerial,
          processedFlag: processedFlag,
        ),
      );

      debugPrint('Sending request: ${jsonEncode(request.toJson())}');

      final response = await apiService.getBills(request);

      // Debug the raw response
      debugPrint('API response result: ${response.result?.toJson()}');
      debugPrint('API response data: ${response.data?.toJson()}');

      if (response.data != null) {
        debugPrint(
            'DeliveryBills count: ${response.data?.deliveryBills?.length ?? 0}');
        if (response.data?.deliveryBills != null &&
            response.data!.deliveryBills!.isNotEmpty) {
          debugPrint(
              'First bill: ${jsonEncode(response.data!.deliveryBills![0].toJson())}');
        }
      }

      if (response.result?.errorNo == 0) {
        final deliveryBills = response.data?.deliveryBills ?? [];
        debugPrint('Returning ${deliveryBills.length} bills');
        return deliveryBills;
      } else {
        debugPrint('API error: ${response.result?.errorMsg}');
        throw ServerException(
          message: response.result?.errorMsg ?? 'Unknown error',
        );
      }
    } catch (e) {
      debugPrint('Exception in getBills: $e');
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<DeliveryStatusModel>> getDeliveryStatuses({
    required String langNo,
  }) async {
    try {
      final request = status_request.GetDeliveryStatusesRequest(
        value: status_request.Value(
          langNo: langNo,
        ),
      );

      final response = await apiService.getDeliveryStatuses(request);

      if (response.result?.errorNo == 0) {
        return response.data?.deliveryStatusTypes ?? [];
      } else {
        throw ServerException(
          message: response.result?.errorMsg ?? 'Unknown error',
        );
      }
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }
}
