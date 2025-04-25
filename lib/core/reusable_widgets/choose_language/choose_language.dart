import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultimate_solution_flutter_task/core/constants/images_constants/images_constants.dart';
import 'package:ultimate_solution_flutter_task/core/constants/strings_constants/strings_constants.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/buttons/custom_main_button.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';
import 'package:ultimate_solution_flutter_task/core/utils/shared_prefs_utils.dart';

class ChooseLanguagePopUp extends StatefulWidget {
  final Function(String) onLanguageSelected;

  const ChooseLanguagePopUp({
    super.key,
    required this.onLanguageSelected,
  });

  static Future<void> show(
      BuildContext context, Function(String) onLanguageSelected) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color(0xFF8E8E93).withOpacity(0.6),
      builder: (BuildContext context) {
        return ChooseLanguagePopUp(
          onLanguageSelected: onLanguageSelected,
        );
      },
    );
  }

  @override
  State<ChooseLanguagePopUp> createState() => _ChooseLanguagePopUpState();
}

class _ChooseLanguagePopUpState extends State<ChooseLanguagePopUp> {
  String _selectedLanguage = 'en'; // Default to English

  @override
  void initState() {
    super.initState();
    // Get currently saved language
    _selectedLanguage = SharedPrefsUtils.getLanguageCode();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsConstants.chooseLanguage.tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A3765),
                  ),
                ),
                SizedBox(height: 30.h),
                _buildLanguageOptions(),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomMainButton(
                    textStyle: TextStyles.font14whiteSemiBold,
                    text: StringsConstants.apply.tr(),
                    backgroundColor: const Color(0xFF275F8E),
                    height: 55,
                    onPressed: () async {
                      // Save selected language to SharedPreferences
                      await SharedPrefsUtils.setLanguageCode(_selectedLanguage);

                      // Call the callback
                      widget.onLanguageSelected(_selectedLanguage);

                      // Close dialog
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLanguageOptions() {
    return Row(
      children: [
        Expanded(
          child: _buildLanguageOption(
            'ar',
            'العربية',
            'Arabic',
            ImagesConstants.arabicFlag,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: _buildLanguageOption(
            'en',
            'English',
            'English',
            ImagesConstants.englishFlag,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageOption(
    String languageCode,
    String primaryText,
    String secondaryText,
    String flagAsset,
  ) {
    final isSelected = _selectedLanguage == languageCode;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = languageCode;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE6F9E9) : Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF2ECC71) : const Color(0xFFE0E0E0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              flagAsset,
              width: 28.r,
              height: 28.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    primaryText,
                    style: TextStyles.font12primaryDarkBold.copyWith(
                      fontSize: languageCode == 'ar' ? 18 : 16,
                      color: const Color(0xFF1A3765),
                    ),
                  ),
                    Text(
                      secondaryText,
                      style: TextStyles.font12primaryDarkBold.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF8E8E93),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
