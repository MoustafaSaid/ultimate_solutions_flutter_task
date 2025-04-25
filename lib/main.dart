import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/pages/home_page.dart';
import 'package:ultimate_solution_flutter_task/app/language/presentation/pages/language_selection_screen.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_cubit.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/pages/login_page.dart';
import 'package:ultimate_solution_flutter_task/core/di/service_locator.dart'
    as di;
import 'package:ultimate_solution_flutter_task/core/utils/shared_prefs_utils.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_solution_flutter_task/core/utils/session_timeout_manager.dart';
import 'package:ultimate_solution_flutter_task/core/utils/user_activity_detector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize easy_localization
  await EasyLocalization.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  // Initialize SharedPreferences
  await SharedPrefsUtils.init();

  // Get saved language code
  final String langCode = SharedPrefsUtils.getLanguageCode();
  final String countryCode = langCode == 'ar' ? 'EG' : 'US';

  runApp(
    EasyLocalization(
      startLocale: Locale(langCode, countryCode),
      supportedLocales: const [Locale("ar", "EG"), Locale("en", "US")],
      fallbackLocale: const Locale("en", "US"),
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Design size based on the provided screenshot (iPhone dimensions)
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return UserActivityDetector(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Orders Delivery',
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: ThemeData(
              primaryColor: Colors.blue,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            home: _getInitialScreen(),
          ),
        );
      },
    );
  }

  Widget _getInitialScreen() {
    // Check if it's the first run of the app
    if (SharedPrefsUtils.isFirstRun()) {
      debugPrint('First run of the app, showing language selection screen');
      return const LanguageSelectionScreen();
    }

    // Check if user is logged in (has delivery number saved)
    String? deliveryNo = SharedPrefsUtils.getDeliveryNo();
    if (deliveryNo != null) {
      debugPrint('User is logged in with delivery number: $deliveryNo');
      return const HomePage();
    }

    // Default to login page
    debugPrint('No saved user credentials, showing login page');
    return BlocProvider(
      create: (context) => di.sl<LoginCubit>(),
      child: const LoginPage(),
    );
  }
}
