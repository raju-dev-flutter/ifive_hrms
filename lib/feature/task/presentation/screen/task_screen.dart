import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifive_hrms/feature/feature.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';

class TaskScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;

  const TaskScreen({super.key, required this.scaffold});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Logger().i("User Token: ${SharedPrefs().getToken()}");
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    final token = SharedPrefs().getToken();
    BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
        .getAttendanceStatus(token);
    BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();

    BlocProvider.of<TaskBarCubit>(context).taskBarItem(TaskItem.INITIATED);
  }

  Widget taskBarItem({
    required void Function() onPressed,
    required String label,
    required Color textColor,
    required Color borderColor,
    required FontWeight fontWeight,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6).w,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4).w,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6).w,
          decoration: BoxDecoration(
            color: appColor.white,
            border: Border.all(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(4).w,
          ),
          child: Text(
            label,
            style: context.textTheme.titleMedium
                ?.copyWith(color: textColor, fontWeight: fontWeight),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: BlocListener<AttendanceStatusCubit, AttendanceStatusState>(
          listener: (context, state) {
            if (state is AttendanceStatusFailed) {
              if (state.message == "Invalid Token") {
                BlocProvider.of<AuthenticationBloc>(context, listen: false)
                    .add(const LoggedOut());
              }
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 110.h,
                child: DashboardHeaderWidget(
                  scaffold: widget.scaffold,
                  actionWidget: IconButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.createSupportTaskScreen),
                    icon: Icon(Icons.add, color: appColor.white),
                  ),
                ),
              ),
              TabBar(
                padding: const EdgeInsets.only(top: 6).w,
                isScrollable: true,
                dragStartBehavior: DragStartBehavior.start,
                tabAlignment: TabAlignment.start,
                labelStyle: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
                unselectedLabelStyle: context.textTheme.labelLarge,
                labelColor: appColor.blue600,
                unselectedLabelColor: appColor.gray600,
                tabs: const [
                  Tab(icon: Text('Created')),
                  Tab(icon: Text('Initiated')),
                  Tab(icon: Text('Pending')),
                  Tab(icon: Text('In Progress')),
                  Tab(icon: Text('Testing L1')),
                  Tab(icon: Text('Testing L2')),
                  Tab(icon: Text('Completed')),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    TaskCreatedScreen(),
                    TaskInitiatedScreen(),
                    TaskPendingScreen(),
                    TaskInProgressScreen(),
                    TaskTestL1Screen(),
                    TaskTestL2Screen(),
                    TaskCompletedScreen(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
