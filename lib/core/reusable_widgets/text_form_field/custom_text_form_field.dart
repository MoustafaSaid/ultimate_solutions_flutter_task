import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextAlign textAlign;
  final TextAlign hintTextAlign;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final double borderWidth;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool isDense;
  final bool isCollapsed;
  final String? helperText;
  final TextStyle? helperStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? maxLength;
  final bool showCounter;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.hintTextAlign = TextAlign.center,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.focusNode,
    this.borderRadius = 25.0,
    this.contentPadding,
    this.filled = true,
    this.fillColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.isDense = false,
    this.isCollapsed = false,
    this.helperText,
    this.helperStyle,
    this.errorText,
    this.errorStyle,
    this.maxLength,
    this.showCounter = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        isDense: isDense,
        isCollapsed: isCollapsed,
        helperText: helperText,
        helperStyle: helperStyle ??
            TextStyles.font12blackRegular,
        errorText: errorText,
        errorStyle: errorStyle ??
            TextStyles.font12blackRegular,
        counter: showCounter ? null : const SizedBox.shrink(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: borderColor ?? ColorsConstants.lightGrey.withValues(alpha: 0.5),
            width: borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: borderColor ?? ColorsConstants.lightGrey.withValues(alpha: 0.5),
            width: borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: ColorsConstants.primaryDark,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: ColorsConstants.error,
            width: borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: ColorsConstants.error,
            width: 1.5,
          ),
        ),
        filled: filled,
        fillColor: fillColor ??
            (enabled
                ? ColorsConstants.black.withValues(alpha: 0.8)
                : ColorsConstants.lightGrey.withValues(alpha: 0.3)),
        hintStyle: hintStyle ??
            TextStyles.font12blackRegular,
        labelStyle: labelStyle ??
            TextStyles.font12blackRegular,
        alignLabelWithHint: hintTextAlign == TextAlign.center,
      ),
      style: textStyle ??
          TextStyles.font12blackRegular,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      onTap: onTap,
      textAlign: textAlign,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      maxLength: maxLength,
    );
  }
}
