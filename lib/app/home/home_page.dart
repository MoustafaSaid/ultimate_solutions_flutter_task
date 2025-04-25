import 'package:flutter/material.dart';
import 'package:ultimate_solution_flutter_task/app/home/widgets/empty_orders_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/widgets/header_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/widgets/orders_list_widget.dart';
import 'package:ultimate_solution_flutter_task/app/home/widgets/tab_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _showEmptyState =
      true;

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
      setState(() {
        _showEmptyState = _tabController.index == 0;
      });
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
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),

          TabBarWidget(tabController: _tabController),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _showEmptyState
                    ? const EmptyOrdersWidget()
                    : const OrdersListWidget(status: 'new'),

                const OrdersListWidget(status: 'others'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
