import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/pages/login_page.dart';
import 'package:ultimate_solution_flutter_task/core/constants/images_constants/images_constants.dart';
import 'package:ultimate_solution_flutter_task/core/constants/strings_constants/strings_constants.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/buttons/custom_main_button.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';
import 'package:ultimate_solution_flutter_task/core/utils/shared_prefs_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_cubit.dart';
import 'package:ultimate_solution_flutter_task/core/di/service_locator.dart'
    as di;

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en'; // Default to English

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringsConstants.chooseLanguage.tr(),
                style: TextStyles.font16primaryDarkSemiBold,
              ),
              SizedBox(height: 40.h),
              Row(
                children: [
                  Expanded(
                    child: _buildLanguageOption(
                      'ar',
                      'العربية',
                      StringsConstants.arabic.tr(),
                      ImagesConstants.arabicFlag,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildLanguageOption(
                      'en',
                      'English',
                      StringsConstants.english.tr(),
                      ImagesConstants.englishFlag,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                child: CustomMainButton(
                  text: StringsConstants.apply.tr(),
                  onPressed: _applyLanguageAndNavigate,
                  backgroundColor: const Color(0xFF275F8E),
                  height: 55,
                  borderRadius: 15,
                  textStyle: TextStyles.font16whiteSemiBold,
                ),
              ),
            ],
          ),
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
            SvgPicture.asset(
              ImagesConstants.arabicFlag,
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

  Future<void> _applyLanguageAndNavigate() async {
    // Save the language preference
    await SharedPrefsUtils.setLanguageCode(_selectedLanguage);

    // Mark first run as completed
    await SharedPrefsUtils.setFirstRun(false);

    // Change app locale with country code
    await context.setLocale(
        Locale(_selectedLanguage, _selectedLanguage == 'ar' ? 'EG' : 'US'));

    // Navigate to login page
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => di.sl<LoginCubit>(),
          child: const LoginPage(),
        ),
      ),
    );
  }
}
