import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/core/constants/strings_constants/strings_constants.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';
class OrderCard extends StatelessWidget {
  final String orderNumber;

  final String status;

  final String totalPrice;

  final String date;

  final VoidCallback onDetailsTap;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.status,
    required this.totalPrice,
    required this.date,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate responsive dimensions based on screen width to avoid overflow
    final screenWidth = MediaQuery.of(context).size.width;

    // Width calculations
    final detailsButtonWidth = screenWidth < 360 ? 60.w : 70.w;
    final contentPadding = screenWidth < 360
        ? EdgeInsets.fromLTRB(12.w, 10.h, 6.w, 10.h)
        : EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 12.h);

    // Font size adjustments
    final labelFontSize = screenWidth < 360 ? 9.0 : 10.0;
    final valueFontSize = screenWidth < 360 ? 12.0 : 14.0;
    final orderNumberFontSize = screenWidth < 360 ? 11.0 : 12.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6.r,
            spreadRadius: 1.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Main content
          Expanded(
            child: Padding(
              padding: contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order number
                  Text(
                    orderNumber,
                    style: TextStyles.font12darkGeyMedium.copyWith(
                      fontSize: orderNumberFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h), // Reduced space

                  // Order details row
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Status column
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  StringsConstants.status.tr(),
                                  style: TextStyles.font10darkGeyMedium.copyWith(
                                    fontSize: labelFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  status,
                                  style: TextStyles.font10darkGeyMedium.copyWith(
                                    fontSize: valueFontSize,
                                    color: _getStatusColor(),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Vertical divider
                          SizedBox(
                            height: 30.h,
                            child: VerticalDivider(
                              width: 10.w,
                              thickness: 1,
                              color: ColorsConstants.lightGrey,
                            ),
                          ),

                          // Total price column
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  StringsConstants.totalPrice.tr(),
                                  style: TextStyles.font10darkGeyMedium.copyWith(
                                    fontSize: labelFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  totalPrice,
                                  style: TextStyles.font16primaryDarkSemiBold.copyWith(
                                    fontSize: valueFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Vertical divider
                          SizedBox(
                            height: 30.h,
                            child: VerticalDivider(
                              width: 10.w,
                              thickness: 1,
                              color: ColorsConstants.lightGrey,
                            ),
                          ),

                          // Date column
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  StringsConstants.date.tr(),
                                  style: TextStyles.font10darkGeyMedium.copyWith(
                                    fontSize: labelFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  date,
                                  style: TextStyles.font16primaryDarkSemiBold.copyWith(
                                    fontSize: valueFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Order details button
          Material(
            color: _getDetailsButtonColor(),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
            child: InkWell(
              onTap: onDetailsTap,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
              child: SizedBox(
                width: detailsButtonWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Order\nDetails',
                        textAlign: TextAlign.center,
                        style: TextStyles.font8whiteRegular.copyWith(
                          fontSize: screenWidth < 360 ? 7 : 8,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: screenWidth < 360 ? 18.sp : 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get the color for the status text based on the order status
  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'new':
        return ColorsConstants.success; // Green for new orders
      case 'returned':
        return ColorsConstants.error; // Red for returned orders
      case 'delivering':
        return ColorsConstants.darkGrey; // Blue for delivering orders
      case 'delivered':
        return ColorsConstants.darkGrey; // Grey for delivered orders
      default:
        return ColorsConstants.darkGrey;
    }
  }

  /// Get the color for the details button based on the order status
  Color _getDetailsButtonColor() {
    switch (status.toLowerCase()) {
      case 'new':
        return ColorsConstants.success; // Green for new orders
      case 'returned':
        return ColorsConstants.error; // Red for returned orders
      case 'delivering':
        return ColorsConstants.darkGrey; // Blue for delivering orders
      case 'delivered':
        return ColorsConstants.darkGrey; // Grey for delivered orders
      default:
        return ColorsConstants.grey;
    }
  }
}
