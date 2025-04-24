import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';

class CustomMainButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final Color backgroundColor;


  final double? width;

  final double height;

  final double borderRadius;

  final TextStyle? textStyle;

  const CustomMainButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = ColorsConstants.primaryDark,
    this.width,
    this.height = 56,
    this.borderRadius = 30.0, // Higher radius to match the pill shape in image
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyles.font16whiteSemiBold,
        ),
      ),
    );
  }
}
