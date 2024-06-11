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
    // final taskBarCubit = BlocProvider.of<TaskBarCubit>(context);
    return DefaultTabController(
        length: 6,
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
/*
   // Padding(
              //   padding: const EdgeInsets.only(
              //           right: 16, left: 16, top: 16, bottom: 6)
              //       .w,
              //   child:
  // BlocBuilder<TaskBarCubit, TaskBarState>(
              //   builder: (context, state) {
              //     return SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         children: [
              //           taskBarItem(
              //             onPressed: () =>
              //                 taskBarCubit.taskBarItem(TaskItem.INITIATED),
              //             label: 'Initiated',
              //             borderColor: state.index == 0
              //                 ? appColor.brand800
              //                 : appColor.gray300,
              //             textColor: state.index == 0
              //                 ? appColor.brand800
              //                 : appColor.gray400,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           taskBarItem(
              //             onPressed: () =>
              //                 taskBarCubit.taskBarItem(TaskItem.PENDING),
              //             label: 'Pending',
              //             borderColor: state.index == 1
              //                 ? appColor.brand800
              //                 : appColor.gray300,
              //             textColor: state.index == 1
              //                 ? appColor.brand800
              //                 : appColor.gray400,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           taskBarItem(
              //             onPressed: () =>
              //                 taskBarCubit.taskBarItem(TaskItem.INPROGRESS),
              //             label: 'In Progress',
              //             borderColor: state.index == 2
              //                 ? appColor.brand800
              //                 : appColor.gray300,
              //             textColor: state.index == 2
              //                 ? appColor.brand800
              //                 : appColor.gray400,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           taskBarItem(
              //             onPressed: () =>
              //                 taskBarCubit.taskBarItem(TaskItem.TESTINGL1),
              //             label: 'Testing L1',
              //             borderColor: state.index == 3
              //                 ? appColor.brand800
              //                 : appColor.gray300,
              //             textColor: state.index == 3
              //                 ? appColor.brand800
              //                 : appColor.gray400,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           taskBarItem(
              //             onPressed: () =>
              //                 taskBarCubit.taskBarItem(TaskItem.TESTINGL2),
              //             label: 'Testing L2',
              //             borderColor: state.index == 4
              //                 ? appColor.brand800
              //                 : appColor.gray300,
              //             textColor: state.index == 4
              //                 ? appColor.brand800
              //                 : appColor.gray400,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           taskBarItem(
              //             onPressed: () =>
              //                 taskBarCubit.taskBarItem(TaskItem.COMPLETED),
              //             label: 'Completed',
              //             borderColor: state.index == 5
              //                 ? appColor.brand800
              //                 : appColor.gray300,
              //             textColor: state.index == 5
              //                 ? appColor.brand800
              //                 : appColor.gray400,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
              // ),
                  // BlocBuilder<TaskBarCubit, TaskBarState>(
                  //     builder: (context, state) {
                  //   if (state.taskItem == TaskItem.INITIATED) {
                  //     return const TaskInitiatedScreen();
                  //   } else if (state.taskItem == TaskItem.PENDING) {
                  //     return const TaskPendingScreen();
                  //   } else if (state.taskItem == TaskItem.INPROGRESS) {
                  //     return const TaskInProgressScreen();
                  //   } else if (state.taskItem == TaskItem.TESTINGL1) {
                  //     return const TaskTestL1Screen();
                  //   } else if (state.taskItem == TaskItem.TESTINGL2) {
                  //     return const TaskTestL2Screen();
                  //   } else if (state.taskItem == TaskItem.COMPLETED) {
                  //     return const TaskCompletedScreen();
                  //   }
                  //   return Container();
                  // }),

                  /// OLD CODE <---- HERE
  var tab = [
    'Initiated',
    'Pending',
    'In Progress',
    'Testing L1',
    'Testing L2',
    'Completed'
  ];

BlocBuilder<StatusBasedTaskCubit, StatusBasedTaskState>(
  builder: (context, state) {
    if (state is StatusBasedTaskLoaded) {
      final task = state.taskPlannerModel.taskPlanner;
      if (task!.isEmpty) return Container();
      return ListView.builder(
        itemCount: task.length,
        padding: Dimensions.kPaddingAllMedium,
        itemBuilder: (_, i) => taskCardUI(task[i]),
      );
    }
    return Container();
  },
),
child: SingleChildScrollView(
  padding: Dimensions.kPaddingAllMedium,
  child: Column(
    children: [
      Container(
        padding:
            const EdgeInsets.only(bottom: 12, left: 16, right: 16)
                .w,
        decoration: BoxDecoration(color: appColor.white),
        child: EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) => initialCallBack(),
          headerProps: EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            selectedDateStyle: context.textTheme.titleMedium,
            monthStyle: context.textTheme.titleMedium,
            padding: const EdgeInsets.symmetric(vertical: 4).w,
          ),
          activeColor: appColor.brand600,
          dayProps: EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            width: 50,
            height: 70,
            todayHighlightStyle: TodayHighlightStyle.withBackground,
            todayHighlightColor: appColor.brand600.withOpacity(.3),
          ),
        ),
      ),
      BlocBuilder<TodayTaskCubit, TodayTaskState>(
        builder: (context, state) {
          if (state is TodayTaskLoaded) {
            final taskPlan = state.taskPlannerModel.taskPlanner;
            if (taskPlan!.isEmpty) {
              return Container();
            }
            return Container(
              padding: const EdgeInsets.only(
                      bottom: 12, left: 16, right: 16)
                  .w,
              decoration: BoxDecoration(color: appColor.white),
              height: 174,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskPlan.length,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: dailyTaskCardUI(taskPlan[i]),
                    );
                  }),
            );
          }
          return Container();
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      BlocBuilder<TaskReportCubit, TaskReportState>(
        builder: (context, state) {
          if (state is TaskReportLoaded) {
            final taskReport = state.taskReport.taskPlannerReport;
            return Container(
              padding: Dimensions.kPaddingAllMedium,
              width: context.deviceSize.width,
              decoration: BoxDecoration(color: appColor.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppSvg.task,
                        width: 14.w,
                        colorFilter: ColorFilter.mode(
                            appColor.gray500, BlendMode.srcIn),
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      Text(
                        'Task',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      taskCartUI(
                        label: 'Initiated',
                        count: taskReport?.initiatedCount ?? "",
                        onPressed: () => Navigator.pushNamed(
                            context,
                            AppRouterPath.taskInitiatedScreen),
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      taskCartUI(
                        label: 'Pending',
                        count: taskReport?.pendingCount ?? "",
                        onPressed: () => Navigator.pushNamed(
                            context,
                            AppRouterPath.taskPendingScreen),
                      ),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      taskCartUI(
                        label: 'In-Progress',
                        count: taskReport?.inProgressCount ?? "",
                        onPressed: () => Navigator.pushNamed(
                            context,
                            AppRouterPath.taskInProgressScreen),
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      taskCartUI(
                        label: 'Test L1',
                        count: taskReport?.testingL1Count ?? "",
                        onPressed: () => Navigator.pushNamed(
                            context,
                            AppRouterPath.taskTestL1Screen),
                      ),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      taskCartUI(
                        label: 'Test L2',
                        count: taskReport?.testingL2Count ?? "",
                        onPressed: () => Navigator.pushNamed(
                            context,
                            AppRouterPath.taskTestL2Screen),
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      taskCartUI(
                        label: 'Completed',
                        count: taskReport?.completedCount ?? "",
                        onPressed: () => Navigator.pushNamed(
                            context,
                            AppRouterPath.taskCompletedScreen),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    ],
  ),
),

  Widget taskCartUI(
      {Color? color,
      required String label,
      required String count,
      required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Dimensions.kBorderRadiusAllSmaller,
      child: Container(
        width: 166.w,
        height: 70.h,
        padding: Dimensions.kPaddingAllSmall,
        decoration: BoxDecoration(
          color: appColor.gray100,
          borderRadius: Dimensions.kBorderRadiusAllSmaller,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 46.w,
              height: 70.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (color ?? appColor.brand600).withOpacity(.2),
                borderRadius: Dimensions.kBorderRadiusAllSmaller,
              ),
              child: Icon(Icons.task, color: color ?? appColor.brand600),
            ),
            Dimensions.kHorizontalSpaceSmaller,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelMedium
                      ?.copyWith(color: appColor.gray600),
                ),
                Text(
                  count,
                  style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color ?? appColor.gray700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dailyTaskCardUI(TaskPlanner taskPlan) {
    return Container(
      width: 300,
      padding: Dimensions.kPaddingAllSmall,
      decoration: BoxDecoration(
        color: appColor.gray100,
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              badge(
                  color: appColor.warning500,
                  label: (taskPlan.priority ?? "").toUpperCase()),
              Dimensions.kHorizontalSpaceSmaller,
              badge(
                  color: appColor.purple500,
                  label: (taskPlan.status ?? "").toUpperCase()),
              Dimensions.kSpacer,
              // Icon(Icons.more_vert_rounded,
              //     size: 18.w, color: appColor.gray700),
            ],
          ),
          Dimensions.kVerticalSpaceSmallest,
          Text(
            taskPlan.task ?? "",
            // 'Lorem ipsum is placeholder.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Dimensions.kVerticalSpaceSmallest,
          Text(
            taskPlan.description ?? "",
            // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium
                ?.copyWith(color: appColor.gray500),
          ),
          Dimensions.kVerticalSpaceSmallest,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.time,
                width: 12.w,
                colorFilter:
                    ColorFilter.mode(appColor.gray500, BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Text(
                '${taskPlan.taskDate ?? ""} ${taskPlan.duration ?? ""}',
                // DateFormat("yyyy-MM-dd hh:mm a").format(selectedDate),
                style: context.textTheme.labelMedium
                    ?.copyWith(color: appColor.gray500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget taskCardUI(TaskPlanner task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
            context, AppRouterPath.taskCompletedDetailScreen),
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
        child: Container(
          padding: Dimensions.kPaddingAllMedium,
          decoration: BoxDecoration(
            color: appColor.white,
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  badge(
                      color: appColor.warning500,
                      label: (task.priority ?? "").toUpperCase()),
                  Dimensions.kHorizontalSpaceSmaller,
                  badge(
                      color: appColor.success600,
                      label: (task.status ?? "").toUpperCase()),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.task ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Dimensions.kVerticalSpaceSmallest,
                        Text(
                          task.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: appColor.gray500),
                        ),
                      ],
                    ),
                  ),
                  Dimensions.kHorizontalSpaceSmaller,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 46.w,
                        height: 46.h,
                        child: CircularProgressIndicator(
                          value: (task.percentage ?? 0).toDouble() / 100,
                          backgroundColor: appColor.gray100,
                          color: appColor.gray100,
                          valueColor: AlwaysStoppedAnimation<Color?>(
                              appColor.success600),
                          strokeWidth: 10,
                          strokeCap: StrokeCap.butt,
                        ),
                      ),
                      Positioned(
                          child: Text(
                        "${task.percentage ?? '0'} %",
                        style: context.textTheme.labelSmall?.copyWith(
                            color: appColor.gray600,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.time,
                    width: 12.w,
                    colorFilter:
                        ColorFilter.mode(appColor.gray500, BlendMode.srcIn),
                  ),
                  Dimensions.kHorizontalSpaceSmaller,
                  Text(
                    task.taskDate ?? '',
                    style: context.textTheme.labelMedium
                        ?.copyWith(color: appColor.gray500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget badge({Color? color, required String label}) {
    return Container(
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        color: (color ?? appColor.blue100).withOpacity(.2),
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
            color: color ?? appColor.blue100, fontWeight: FontWeight.bold),
      ),
    );
  }
*/
