import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultimate_solution_flutter_task/core/constants/images_constants/images_constants.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 127.h,
          decoration: const BoxDecoration(
            color: ColorsConstants.error,
          ),
        ),

        Positioned(
          right: 0,
          top: 0,
          child: SvgPicture.asset(
            ImagesConstants.blueCircle,
          ),
        ),

        Positioned(
          right: 60,
          bottom: 0,
          child: Image.asset(
            ImagesConstants.deliveryman,
            fit: BoxFit.contain,
          ),
        ),

        // User info
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, top: 23.h),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Ahmed\n',
                    style: TextStyles.font25whiteMedium,
                  ),
                  TextSpan(
                    text: 'Othman',
                    style: TextStyles.font25whiteBold,
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          right: 17.w,
          top: 43.h,
          child: Container(
            height: 24.h,
            width: 24.h,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: ColorsConstants.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(
              ImagesConstants.language,
              colorFilter: ColorFilter.mode(
                  ColorsConstants.primaryDark, BlendMode.srcIn),
              height: 16,
              width: 16,
            ),
          ),
        ),
      ],
    );
  }
}
