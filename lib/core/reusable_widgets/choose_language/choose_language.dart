import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/core/constants/strings_constants/strings_constants.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/buttons/custom_main_button.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';

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
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      backgroundColor: ColorsConstants.white,
      child: Padding(
        padding: EdgeInsets.all(25.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              StringsConstants.chooseLanguage.tr(),
              style: TextStyles.font12primaryDarkBold,
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: _buildLanguageOption(
                    'ar',
                    'العربية',
                    'Arabic',
                    'assets/images/arabic_flag.png',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildLanguageOption(
                    'en',
                    'English',
                    'English',
                    'assets/images/english_flag.png',
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            SizedBox(
              width: double.infinity,
              child: CustomMainButton(
                text: StringsConstants.apply.tr(),
                onPressed: () {
                  widget.onLanguageSelected(_selectedLanguage);
                  Navigator.of(context).pop();
                },
                backgroundColor: const Color(0xFF275F8E),
                height: 55,
                borderRadius: 15,
                textStyle: TextStyles.font16whiteSemiBold,
              ),
            ),
          ],
        ),
      ),
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
          color: isSelected ? const Color(0xFFE6F9E9) : ColorsConstants.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color:
            isSelected ? const Color(0xFF2ECC71) : const Color(0xFFE0E0E0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14.r,
              backgroundImage: AssetImage(flagAsset),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    primaryText,
                            style: TextStyles.font12primaryDarkBold.copyWith
                    (
                      fontSize: languageCode == 'ar' ? 18 : 16,
                      color: const Color(0xFF1A3765),
                    ),
                  ),
                  if (secondaryText != primaryText)
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
