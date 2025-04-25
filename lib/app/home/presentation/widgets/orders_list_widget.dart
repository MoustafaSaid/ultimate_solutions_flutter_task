import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/bill_entity.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/cards/orders_card.dart';

class OrdersListWidget extends StatelessWidget {
  final String status;
  final List<BillEntity> bills;

  const OrdersListWidget({
    Key? key,
    required this.status,
    required this.bills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bills.isEmpty) {
      return Center(
        child: Text(
          'No ${status.toLowerCase()} orders available',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final bill = bills[index];
        return OrderCard(
          orderNumber: '#${bill.billNo}',
          status: bill.deliveryStatusName?.isNotEmpty == true
              ? bill.deliveryStatusName ?? 'Unknown'
              : (status == 'new' ? 'New' : 'Processing'),
          totalPrice: '${bill.billAmount ?? 0} LE',
          date: bill.billDate ?? '',
          onDetailsTap: () {
            // Navigate to order details page
            // In a real app, this would be implemented to navigate to the order details
            debugPrint('Navigating to details for bill: ${bill.billNo}');
          },
        );
      },
    );
  }
}
