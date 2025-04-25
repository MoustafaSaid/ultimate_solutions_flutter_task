import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/bill_entity.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/delivery_status_entity.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/usecases/get_bills_usecase.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/usecases/get_delivery_statuses_usecase.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/cubit/home_state.dart';
import 'package:ultimate_solution_flutter_task/core/error/failures.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBillsUseCase getBillsUseCase;
  final GetDeliveryStatusesUseCase getDeliveryStatusesUseCase;

  HomeCubit({
    required this.getBillsUseCase,
    required this.getDeliveryStatusesUseCase,
  }) : super(const HomeState());

  Future<void> fetchData({
    required String deliveryNo,
    required String langNo,
    String billSerial = "",
    String processedFlag = "",
  }) async {
    emit(state.copyWith(status: HomeStatus.loading));

    // First, get delivery statuses
    final statusesResult = await getDeliveryStatusesUseCase(langNo: langNo);

    await statusesResult.fold(
      (failure) async {
        // If getting delivery statuses fails, try to get bills anyway
        print("error $failure");
        await _fetchBills(
          deliveryNo: deliveryNo,
          langNo: langNo,
          billSerial: billSerial,
          processedFlag: processedFlag,
        );
      },
      (statuses) async {
        // Update state with statuses and then fetch bills
        print("success $statuses");

        emit(state.copyWith(deliveryStatuses: statuses));
        await _fetchBills(
          deliveryNo: deliveryNo,
          langNo: langNo,
          billSerial: billSerial,
          processedFlag: processedFlag,
        );
      },
    );
  }

  Future<void> _fetchBills({
    required String deliveryNo,
    required String langNo,
    String billSerial = "",
    String processedFlag = "",
  }) async {
    debugPrint('Fetching bills with deliveryNo: $deliveryNo, langNo: $langNo');

    final result = await getBillsUseCase(
      deliveryNo: deliveryNo,
      langNo: langNo,
      billSerial: billSerial,
      processedFlag: processedFlag,
    );

    result.fold(
      (failure) {
        debugPrint('API call failed with error: ${failure.message}');

        // If API call fails with a connection error, we'll already have
        // tried to get cached data in the use case, so just update the UI state
        if (failure is ConnectionFailure) {
          if (state.bills.isEmpty) {
            emit(state.copyWith(
              status: HomeStatus.empty,
              errorMessage: failure.message,
            ));
          } else {
            emit(state.copyWith(
              status: HomeStatus.success,
              errorMessage: failure.message,
            ));
          }
        } else {
          emit(state.copyWith(
            status: HomeStatus.error,
            errorMessage: failure.message,
          ));
        }
      },
      (bills) {
        print("success data $bills");


        if (bills.isEmpty) {
          debugPrint('Bills list is empty, showing empty state');
          emit(state.copyWith(status: HomeStatus.empty));
        } else {
          // Map delivery status name to each bill if available
          final List<BillEntity> billsWithStatuses =
              _mapDeliveryStatusNames(bills);

          // Print the first few bills for debugging
          if (billsWithStatuses.isNotEmpty) {
          }

          emit(state.copyWith(
            status: HomeStatus.success,
            bills: billsWithStatuses,
          ));
        }
      },
    );
  }

  List<BillEntity> _mapDeliveryStatusNames(List<BillEntity> bills) {
    if (state.deliveryStatuses.isEmpty) {
      return bills;
    }

    return bills.map((bill) {
      // Find matching delivery status
      final matchingStatus = state.deliveryStatuses.firstWhere(
        (status) => status.typeNo == bill.deliveryStatusFlag,
        orElse: () => const DeliveryStatusEntity(typeNo: '', typeName: ''),
      );

      // If we found a match, create a new bill with the status name
      if (matchingStatus.typeNo.isNotEmpty) {
        return BillEntity(
          billType: bill.billType,
          billNo: bill.billNo,
          billSerial: bill.billSerial,
          billDate: bill.billDate,
          billTime: bill.billTime,
          billAmount: bill.billAmount,
          taxAmount: bill.taxAmount,
          deliveryAmount: bill.deliveryAmount,
          mobileNo: bill.mobileNo,
          customerName: bill.customerName,
          regionName: bill.regionName,
          buildingNo: bill.buildingNo,
          floorNo: bill.floorNo,
          apartmentNo: bill.apartmentNo,
          address: bill.address,
          latitude: bill.latitude,
          longitude: bill.longitude,
          deliveryStatusFlag: bill.deliveryStatusFlag,
          deliveryStatusName: matchingStatus.typeName,
        );
      }

      return bill;
    }).toList();
  }

  void refreshData({
    required String deliveryNo,
    required String langNo,
    String billSerial = "",
    String processedFlag = "",
  }) {
    debugPrint('Refreshing data with deliveryNo: $deliveryNo');
    fetchData(
      deliveryNo: deliveryNo,
      langNo: langNo,
      billSerial: billSerial,
      processedFlag: processedFlag,
    );
  }
}
