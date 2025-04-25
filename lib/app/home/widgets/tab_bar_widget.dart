import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ultimate_solution_flutter_task/core/constants/strings_constants/strings_constants.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';

class TabBarWidget extends StatelessWidget {
  final TabController tabController;

  const TabBarWidget({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Container(
        height: 48.h,
        width: MediaQuery.of(context).size.width *
            0.6, // Adjust width to match design
        decoration: BoxDecoration(
          color: ColorsConstants.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6.r,
              spreadRadius: 0.5.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: TabBar(
            controller: tabController,
            labelColor: ColorsConstants.white,
            unselectedLabelColor: ColorsConstants.primaryDark,
            labelStyle: TextStyles.font14whiteSemiBold,
            unselectedLabelStyle: TextStyles.font14primaryDarkSemiBold,
            splashFactory: NoSplash.splashFactory,
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            indicator: BoxDecoration(
              color: ColorsConstants.primaryDark,
              borderRadius: BorderRadius.circular(30.r),
            ),
            splashBorderRadius: BorderRadius.circular(30.r),
            dividerHeight: 0,
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    StringsConstants.newItems.tr(),
                    style: tabController.index == 0
                        ? TextStyles.font14whiteSemiBold
                        : TextStyles.font14primaryDarkSemiBold,
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    StringsConstants.others.tr(),
                    style: tabController.index == 1
                        ? TextStyles.font14whiteSemiBold
                        : TextStyles.font14primaryDarkSemiBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
