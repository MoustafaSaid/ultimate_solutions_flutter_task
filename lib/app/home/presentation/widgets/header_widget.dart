import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/cubit/home_cubit.dart';
import 'package:ultimate_solution_flutter_task/core/constants/images_constants/images_constants.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/choose_language/choose_language.dart';
import 'package:ultimate_solution_flutter_task/core/theme/colors_manager/colors_manager.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';
import 'package:ultimate_solution_flutter_task/core/utils/shared_prefs_utils.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, required this.deliveryNo});
  final String deliveryNo;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget>
    with SingleTickerProviderStateMixin {
  // Initialize langNo based on SharedPreferences
  String langNo = SharedPrefsUtils.getLanguageCode() == 'ar' ? "1" : "2";

  // Get current locale for UI updates
  String get currentLanguageCode => SharedPrefsUtils.getLanguageCode();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = currentLanguageCode == 'ar';

    // Get the delivery person's name from login state in SharedPrefs
    final deliveryFullName =
        SharedPrefsUtils.getDeliveryName() ?? 'Delivery Person';

    // Split the name into multiple components for better display
    final nameParts = deliveryFullName.split(' ');
    List<String> nameSegments = [];

    // Process name parts into at most 3 segments
    if (nameParts.length <= 1) {
      // Single name
      nameSegments = [nameParts.first];
    } else if (nameParts.length == 2) {
      // First and last name
      nameSegments = [nameParts.first, nameParts.last];
    } else {
      // Multiple name parts - organize into 3 segments
      nameSegments = [
        nameParts.first, // First name
        nameParts[1], // Middle name or part of last name
        nameParts.sublist(2).join(' ') // Everything else combined
      ];
    }

    // Use a fixed layout that doesn't change with language
    return Stack(
      children: [
        // Background container
        Container(
          height: 127.h,
          decoration: const BoxDecoration(
            color: ColorsConstants.error,
          ),
        ),

        // Blue circle - fixed position
        Positioned(
          right: 0,
          top: 0,
          child: SvgPicture.asset(
            ImagesConstants.blueCircle,
          ),
        ),

        // Delivery man - fixed position
        Positioned(
          right: 60,
          bottom: 0,
          child: Image.asset(
            ImagesConstants.deliveryman,
            fit: BoxFit.contain,
          ),
        ),

        // User info - fixed position with smaller text
        Positioned(
          left: 16.w,
          top: MediaQuery.of(context).padding.top + 23.h,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5, // Limit width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: nameSegments.asMap().entries.map((entry) {
                final index = entry.key;
                final segment = entry.value;

                // Make the first segment medium weight, middle bold, last extra bold
                TextStyle style;
                if (index == 0) {
                  style = TextStyles.font16whiteMedium;
                } else if (index == 1) {
                  style = TextStyles.font16whiteSemiBold;
                } else {
                  style = TextStyles.font14whiteSemiBold;
                }

                return Text(
                  segment,
                  style: style,
                  overflow: TextOverflow.ellipsis,
                );
              }).toList(),
            ),
          ),
        ),

        // Language selector - fixed position on right side
        Positioned(
          right: 17.w,
          top: 43.h,
          child: GestureDetector(
            onTap: () {
              _animationController.reset();
              _animationController.forward();
              _showLanguageSelector();
            },
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isArabic
                        ? 1.0 + (_animationController.value * 0.1)
                        : 1.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: isArabic ? 36.h : 24.h,
                      width: isArabic ? 36.h : 24.h,
                      padding: EdgeInsets.all(isArabic ? 6 : 4),
                      decoration: BoxDecoration(
                        color: isArabic
                            ? ColorsConstants.primaryDark
                            : ColorsConstants.white,
                        borderRadius:
                            BorderRadius.circular(isArabic ? 10.r : 8.r),
                        boxShadow: [
                          if (isArabic)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        ImagesConstants.language,
                        colorFilter: ColorFilter.mode(
                            isArabic
                                ? ColorsConstants.white
                                : ColorsConstants.primaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  void _showLanguageSelector() {
    ChooseLanguagePopUp.show(context, (languageCode) async {
      // Save selected language to SharedPreferences first
      await SharedPrefsUtils.setLanguageCode(languageCode);

      // Update langNo for API calls
      setState(() {
        langNo = languageCode == 'ar' ? "1" : "2";
      });

      // Change locale with country code
      if (context.mounted) {
        await context.setLocale(
            Locale(languageCode, languageCode == 'ar' ? 'EG' : 'US'));
      }

      // Refresh data with new language - using the widget's HomeCubit
      if (context.mounted) {
        // Trigger a full refresh
        context.read<HomeCubit>().refreshData(
              deliveryNo: widget.deliveryNo,
              langNo: langNo,
            );

        // Force the parent to rebuild as well
        if (context.mounted) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (context.mounted) {
              // Find any state widget that has a setState method
              final ancestor = context.findAncestorStateOfType<State>();
              if (ancestor != null && ancestor.mounted) {
                ancestor.setState(() {});
              }
            }
          });
        }
      }
    });
  }
}
