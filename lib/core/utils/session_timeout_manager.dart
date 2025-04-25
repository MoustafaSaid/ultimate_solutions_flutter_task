import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/pages/login_page.dart';
import 'package:ultimate_solution_flutter_task/core/di/service_locator.dart'
    as di;
import 'package:ultimate_solution_flutter_task/core/utils/shared_prefs_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_cubit.dart';

/// Global navigator key that can be used to navigate from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SessionTimeoutManager {
  // Use factory constructor instead of singleton pattern
  // as the object will be created by the GetIt service locator

  // Session timeout duration (2 minutes)
  static const int _sessionTimeoutSeconds = 120;

  Timer? _sessionTimer;
  bool _isInitialized = false;

  // Initialize the session timeout manager
  void initialize(BuildContext context) {
    if (_isInitialized) return;

    _isInitialized = true;
    _resetSessionTimer();
  }

  // Extend the session timer - call this when user interacts with app
  void userActivity(BuildContext context) {
    if (!_isInitialized) {
      initialize(context);
      return;
    }

    _resetSessionTimer();
  }

  // Reset the session timer
  void _resetSessionTimer() {
    // Cancel existing timer if any
    _sessionTimer?.cancel();

    // Start a new timer
    _sessionTimer = Timer(const Duration(seconds: _sessionTimeoutSeconds), () {
      _handleSessionTimeout();
    });
  }

  // Handle session timeout
  void _handleSessionTimeout() {
    // Only log out if user is logged in
    if (SharedPrefsUtils.getDeliveryNo() != null) {
      // Clear user data
      SharedPrefsUtils.clearUserData();

      // Get navigator state from global key
      final NavigatorState? navigator = navigatorKey.currentState;

      // Check if navigator is available
      if (navigator != null && navigatorKey.currentContext != null) {
        try {
          // Show session expired message
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            const SnackBar(
              content: Text('Session expired. Please log in again.'),
              backgroundColor: Colors.red,
            ),
          );

          // Navigate to login page
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => di.sl<LoginCubit>(),
                child: const LoginPage(),
              ),
            ),
            (route) => false,
          );
        } catch (e) {
          debugPrint('Error during session timeout handling: $e');
        }
      }
    }
  }

  // Stop the session timer (call this when logging out manually)
  void stopSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = null;
    _isInitialized = false;
  }
}
