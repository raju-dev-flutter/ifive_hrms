import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../expenses.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: appColor.gray50,
        appBar: PreferredSize(
          preferredSize: Size(context.deviceSize.width, 90.h),
          child: CustomAppBar(
            onPressed: () => Navigator.pop(context),
            title: "Expenses",
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(
                    context, AppRouterPath.expensesRequestScreen),
                icon: Icon(Icons.add, color: appColor.gray900),
              ),
            ],
            bottom: TabBar(
              indicatorPadding: const EdgeInsets.all(0).w,
              labelPadding: const EdgeInsets.all(0).w,
              unselectedLabelColor: appColor.gray700,
              unselectedLabelStyle: context.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              labelStyle: context.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              isScrollable: false,
              onTap: (val) {
                // if (val == 0) initialCallBack();
                // if (val == 1) initialCallBack();
              },
              tabs: const [Tab(text: 'APPROVAL'), Tab(text: 'HISTORY')],
            ),
          ),
        ),
        body: _buildBodyUI(),
      ),
    );
  }

  Widget _buildBodyUI() {
    return const TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [ExpensesApprovalScreen(), ExpensesHistoryScreen()],
    );
  }
}
