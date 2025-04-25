import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/cards/orders_card.dart';

class OrdersListWidget extends StatelessWidget {
  final String status;

  const OrdersListWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is a mock implementation. In a real app, this would fetch data from a repository
    // and display it based on the status (new or others)

    // If status is 'new', show only new orders
    // If status is 'others', show orders with status delivering, delivered, returned, etc.

    // For demonstration purposes, we'll create mock data
    final List<Map<String, String>> orders = _getMockOrders();

    return ListView.builder(
      padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          orderNumber: order['orderNumber']!,
          status: order['status']!,
          totalPrice: order['totalPrice']!,
          date: order['date']!,
          onDetailsTap: () {
            // Navigate to order details page
            // In a real app, this would be implemented to navigate to the order details
            debugPrint(
                'Navigating to details for order: ${order['orderNumber']}');
          },
        );
      },
    );
  }

  List<Map<String, String>> _getMockOrders() {
    if (status == 'new') {
      // Return only new orders
      return List.generate(
        5,
        (index) => {
          'orderNumber': '#1569987',
          'status': 'New',
          'totalPrice': '400 LE',
          'date': '1/1/2020',
        },
      );
    } else {
      // Return orders with various statuses for the 'Others' tab
      return [
        {
          'orderNumber': '#1569999',
          'status': 'Delivering',
          'totalPrice': '6378 LE',
          'date': '11/6/2020',
        },
        {
          'orderNumber': '#1569987',
          'status': 'Returned',
          'totalPrice': '400 LE',
          'date': '1/1/2020',
        },
        {
          'orderNumber': '#1569999',
          'status': 'Delivered',
          'totalPrice': '6378 LE',
          'date': '11/6/2020',
        },
        {
          'orderNumber': '#1569987',
          'status': 'Returned',
          'totalPrice': '400 LE',
          'date': '1/1/2020',
        },
        {
          'orderNumber': '#1569999',
          'status': 'Delivered',
          'totalPrice': '6378 LE',
          'date': '11/6/2020',
        },
        {
          'orderNumber': '#1569999',
          'status': 'Delivering',
          'totalPrice': '6378 LE',
          'date': '11/6/2020',
        },
      ];
    }
  }
}
