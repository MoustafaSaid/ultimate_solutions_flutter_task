import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ultimate_solution_flutter_task/app/home/widgets/tab_bar_widget.dart';

void main() {
  testWidgets('TabBarWidget displays correctly and responds to taps',
      (WidgetTester tester) async {
    // Create a TabController for testing
    late TabController tabController;

    // Build our widget tree.
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            tabController = TabController(length: 2, vsync: tester);

            // Make ScreenUtil compatible with tests
            ScreenUtil.init(
              context,
              designSize: const Size(393, 852),
              minTextAdapt: true,
              splitScreenMode: true,
            );

            return Scaffold(
              body: Column(
                children: [
                  TabBarWidget(tabController: tabController),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        Center(child: Text('New Tab Content')),
                        Center(child: Text('Others Tab Content')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    // Initial state should show first tab selected
    expect(tabController.index, 0);

    // Verify the tab labels are correctly displayed
    expect(find.text('newItems'), findsOneWidget);
    expect(find.text('others'), findsOneWidget);

    // Tap the second tab
    await tester.tap(find.text('others'));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Verify the controller has updated
    expect(tabController.index, 1);

    // Verify the correct tab content is displayed
    expect(find.text('Others Tab Content'), findsOneWidget);
    expect(find.text('New Tab Content'), findsNothing);

    // Tap the first tab again
    await tester.tap(find.text('newItems'));
    await tester.pumpAndSettle();

    // Verify the controller has updated
    expect(tabController.index, 0);

    // Verify the correct tab content is displayed
    expect(find.text('New Tab Content'), findsOneWidget);
    expect(find.text('Others Tab Content'), findsNothing);
  });
}
