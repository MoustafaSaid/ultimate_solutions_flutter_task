import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/cubit/home_cubit.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/cubit/home_state.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/empty_orders_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/error_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/header_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/loading_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/orders_list_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/tab_bar_widget.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/pages/login_page.dart';
import 'package:ultimate_solution_flutter_task/core/constants/images_constants/images_constants.dart';
import 'package:ultimate_solution_flutter_task/core/di/service_locator.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/choose_language/choose_language.dart';
import 'package:ultimate_solution_flutter_task/core/utils/session_timeout_manager.dart';
import 'package:ultimate_solution_flutter_task/core/utils/shared_prefs_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  String? deliveryNo;
  String langNo = "2"; // Default to English

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 300),
    );

    _tabController.addListener(_handleTabChange);

    // Get saved delivery number
    deliveryNo = SharedPrefsUtils.getDeliveryNo();
    if (deliveryNo == null) {
      debugPrint('No cached delivery number found, using default');
      deliveryNo = "1010"; // Default if not available
    } else {
      debugPrint('Using cached delivery number: $deliveryNo');
    }

    // Set language number based on saved language code
    langNo = SharedPrefsUtils.getLanguageCode() == 'ar' ? "1" : "2";
    debugPrint('Using language number: $langNo');

    // Initialize session timeout manager after widget build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<SessionTimeoutManager>().initialize(context);

      // Force a rebuild of the header widget to ensure delivery name is displayed
      setState(() {});
    });
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  // Update language after it changes in the header
  void updateLanguage(String newLangNo) {
    setState(() {
      langNo = newLangNo;
    });

    // Refresh data with new language
    context.read<HomeCubit>().refreshData(
          deliveryNo: deliveryNo!,
          langNo: langNo,
        );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()
        ..fetchData(
          deliveryNo: deliveryNo!,
          langNo: langNo,
        ),
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                HeaderWidget(deliveryNo: deliveryNo!),
                // Language icon for switching
                // Positioned(
                //   right: 16,
                //   top: 40,
                //   child: GestureDetector(
                //     onTap: _showLanguageSelector,
                //     child: SvgPicture.asset(
                //       ImagesConstants.language,
                //       width: 28,
                //       height: 28,
                //     ),
                //   ),
                // ),
              ],
            ),
            TabBarWidget(tabController: _tabController),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                // Add more debugging prints to help troubleshoot
                debugPrint('Current state: ${state.status}');
                debugPrint('Bills count: ${state.bills.length}');

                // Detailed debugging for bills data
                if (state.bills.isNotEmpty) {
                  debugPrint('First bill details:');
                  debugPrint('- billNo: ${state.bills[0].billNo}');
                  debugPrint(
                      '- deliveryStatusFlag: ${state.bills[0].deliveryStatusFlag}');
                  debugPrint(
                      '- deliveryStatusName: ${state.bills[0].deliveryStatusName ?? "null"}');

                  // Calculate tab counts for debugging
                  final newBills = state.bills
                      .where((bill) =>
                          bill.deliveryStatusFlag == '1' ||
                          bill.deliveryStatusFlag == '')
                      .toList();
                  final otherBills = state.bills
                      .where((bill) =>
                          bill.deliveryStatusFlag != '1' &&
                          bill.deliveryStatusFlag != '')
                      .toList();

                  debugPrint('New bills count: ${newBills.length}');
                  debugPrint('Other bills count: ${otherBills.length}');
                }

                if (state.isLoading) {
                  return const Expanded(child: LoadingWidget());
                } else if (state.isError) {
                  return Expanded(
                    child: ErrorDisplayWidget(
                      message: state.errorMessage,
                      onRetry: () => context.read<HomeCubit>().refreshData(
                            deliveryNo: deliveryNo!,
                            langNo: langNo,
                          ),
                    ),
                  );
                } else if (state.isEmpty && state.bills.isEmpty) {
                  return const Expanded(child: EmptyOrdersWidget());
                } else if (state.isSuccess || state.bills.isNotEmpty) {
                  // If status is success or we have bills but status doesn't reflect it
                  return Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Filter bills by status for "new" tab
                        OrdersListWidget(
                          status: 'new',
                          bills: state.bills
                              .where((bill) =>
                                  bill.deliveryStatusFlag ==
                                      '1' || // Assuming '1' is for new orders
                                  bill.deliveryStatusFlag == '')
                              .toList(),
                        ),

                        // Filter bills for "others" tab
                        OrdersListWidget(
                          status: 'others',
                          bills: state.bills
                              .where((bill) =>
                                  bill.deliveryStatusFlag != '1' &&
                                  bill.deliveryStatusFlag != '')
                              .toList(),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Fallback in case we have bills but state is in another status
                  // This ensures data is always displayed if available
                  return Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Filter bills by status for "new" tab
                        OrdersListWidget(
                          status: 'new',
                          bills: state.bills
                              .where((bill) =>
                                  bill.deliveryStatusFlag ==
                                      '1' || // Assuming '1' is for new orders
                                  bill.deliveryStatusFlag == '')
                              .toList(),
                        ),

                        // Filter bills for "others" tab
                        OrdersListWidget(
                          status: 'others',
                          bills: state.bills
                              .where((bill) =>
                                  bill.deliveryStatusFlag != '1' &&
                                  bill.deliveryStatusFlag != '')
                              .toList(),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
