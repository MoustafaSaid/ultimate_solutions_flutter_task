import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ultimate_solution_flutter_task/core/constants/images_constants/images_constants.dart';
import 'package:ultimate_solution_flutter_task/core/constants/strings_constants/strings_constants.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';

class EmptyOrdersWidget extends StatelessWidget {
  const EmptyOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty order icon with blob background
          Center(
            child: SvgPicture.asset(
ImagesConstants.emptyOrder,              // Use a slightly darker color for the icon
            ),
          ),
          SizedBox(height: 32.h),

          // No orders title - using the exact font size and weight from design
          Text(
            StringsConstants.noOrdersTitle.tr(),
            style: TextStyles.font23blackSemiBold,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // No orders subtitle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              StringsConstants.noOrdersSubTitle.tr(),
              style: TextStyles.font14BlackRegular.copyWith(
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
