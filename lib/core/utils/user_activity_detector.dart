import 'package:flutter/material.dart';
import 'package:ultimate_solution_flutter_task/core/di/service_locator.dart'
    as di;
import 'package:ultimate_solution_flutter_task/core/utils/session_timeout_manager.dart';

class UserActivityDetector extends StatelessWidget {
  final Widget child;

  const UserActivityDetector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Store the current context to be used later
    final currentContext = context;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _handleUserInteraction(currentContext),
      onPanDown: (_) => _handleUserInteraction(currentContext),
      onScaleStart: (_) => _handleUserInteraction(currentContext),
      child: Listener(
        onPointerDown: (_) => _handleUserInteraction(currentContext),
        onPointerMove: (_) => _handleUserInteraction(currentContext),
        onPointerSignal: (_) => _handleUserInteraction(currentContext),
        child: child,
      ),
    );
  }

  void _handleUserInteraction(BuildContext context) {
    try {
      // Reset session timer on user interaction
      di.sl<SessionTimeoutManager>().userActivity(context);
    } catch (e) {
      debugPrint('Error in user activity detection: $e');
    }
  }
}
