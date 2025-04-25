import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/cubit/home_cubit.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/cubit/home_state.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/empty_orders_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/error_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/header_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/loading_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/orders_list_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/presentation/widgets/tab_bar_widget.dart';
import 'package:ultimate_solution_flutter_task/core/di/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  // Constants for API parameters
  static const String deliveryNo = "1010";
  static const String langNo = "1";

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 300),
    );

    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      setState(() {});
    }
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
          deliveryNo: deliveryNo,
          langNo: langNo,
        ),
      child: Scaffold(
        body: Column(
          children: [
            const HeaderWidget(),
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
                            deliveryNo: deliveryNo,
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
        floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () => context.read<HomeCubit>().refreshData(
                    deliveryNo: deliveryNo,
                    langNo: langNo,
                  ),
              child: const Icon(Icons.refresh),
            );
          },
        ),
      ),
    );
  }
}
