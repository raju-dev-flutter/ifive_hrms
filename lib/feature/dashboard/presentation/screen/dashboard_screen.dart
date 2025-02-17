part of 'screen.dart';

class DashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;

  const DashboardScreen({super.key, required this.scaffold});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

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
    BlocProvider.of<DashboardCountCubit>(context).dashboardCount();
    BlocProvider.of<TaskLeadCubit>(context).taskLead();

    BlocProvider.of<LeaveApprovedCubit>(context).getLeaveApproved(
        DateFormat('yyyy-MM-dd').format(selectedFromDate),
        DateFormat('yyyy-MM-dd').format(selectedToDate));
    BlocProvider.of<MisspunchApprovedCubit>(context).misspunchApproved(
        DateFormat('yyyy-MM-dd').format(selectedFromDate),
        DateFormat('yyyy-MM-dd').format(selectedToDate));
    BlocProvider.of<PermissionHistoryCubit>(context).getPermissionHistory();
  }

  @override
  Widget build(BuildContext context) {
    final tabBarCubit = BlocProvider.of<DashboardTabBarCubit>(context);
    return BlocListener<AttendanceStatusCubit, AttendanceStatusState>(
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
            height: 116.h,
            child: DashboardHeaderWidget(scaffold: widget.scaffold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 116.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 60.h,
                          padding: Dimensions.kPaddingAllSmall,
                          decoration: BoxDecoration(color: appColor.brand800),
                        ),
                        _DashboardAttendanceLog(),
                      ],
                    ),
                  ),
                  const DashboardCarouselSlider(),
                  const _DashboardProjectLeadTaskWidget(),
                  // Dimensions.kVerticalSpaceSmall,
                  const _DashboardLmsDetailsWidget(),
                  Dimensions.kVerticalSpaceMedium,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardProjectLeadTaskWidget extends StatelessWidget {
  const _DashboardProjectLeadTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskLeadCubit, TaskLeadState>(
      builder: (context, state) {
        if (state is TaskLeadLoaded) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 12, right: 16).w,
            child: Container(
              height: 284.h,
              padding: Dimensions.kPaddingAllSmall,
              decoration: BoxDecoration(
                color: appColor.white,
                borderRadius: Dimensions.kBorderRadiusAllMedium,
                boxShadow: [
                  BoxShadow(
                    color: appColor.gray200.withOpacity(.4),
                    offset: const Offset(0, 3),
                    spreadRadius: 3,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _DashboardTopBarHeaderItem(
                        onPressed: () {},
                        label: "Lead Task",
                        count:
                            "${state.taskLead.isNotEmpty ? state.taskLead.length : 0}",
                        isActive: true,
                      ),
                      Dimensions.kSpacer,
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRouterPath.leadTaskScreen),
                        child: Row(
                          children: [
                            Text("All Lead Task",
                                style: context.textTheme.titleSmall?.copyWith(
                                    fontSize: 12, color: appColor.brand600)),
                            SizedBox(width: 6.w),
                            SvgPicture.asset(
                              AppSvg.rightArrow,
                              width: 6.w,
                              colorFilter: ColorFilter.mode(
                                  appColor.brand600, BlendMode.srcIn),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  SizedBox(
                    width: context.deviceSize.width,
                    height: 215.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, i) {
                        return _TaskLeadDetailWidget(task: state.taskLead[i]);
                      },
                      separatorBuilder: (_, i) =>
                          Dimensions.kHorizontalSpaceSmaller,
                      itemCount: state.taskLead.length,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _DashboardLmsDetailsWidget extends StatelessWidget {
  const _DashboardLmsDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tabBarCubit = BlocProvider.of<DashboardTabBarCubit>(context);
    return Container(
      height: 400.h,
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: BlocBuilder<DashboardTabBarCubit, DashboardTabBarState>(
        builder: (context, dashState) {
          return Container(
            padding: Dimensions.kPaddingAllSmall,
            decoration: BoxDecoration(
              color: appColor.white,
              borderRadius: Dimensions.kBorderRadiusAllMedium,
              boxShadow: [
                BoxShadow(
                  color: appColor.gray200.withOpacity(.4),
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: context.deviceSize.width,
                  padding: Dimensions.kPaddingAllSmaller,
                  decoration: BoxDecoration(
                    color: appColor.gray100,
                    borderRadius: Dimensions.kBorderRadiusAllLarger,
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<LeaveApprovedCubit, LeaveApprovedState>(
                        builder: (context, state) {
                          if (state is LeaveApprovedLoaded) {
                            return _DashboardTopBarHeaderItem(
                              onPressed: () => tabBarCubit
                                  .getTabBarItem(DashboardTabItem.leave),
                              label: "Leave",
                              count: state.approved.leavelist!.isEmpty
                                  ? "0"
                                  : state.approved.leavelist!.length.toString(),
                              isActive:
                                  tabBarCubit.state.index == 0 ? true : false,
                            );
                          }
                          return _DashboardTopBarHeaderItem(
                            onPressed: () => tabBarCubit
                                .getTabBarItem(DashboardTabItem.leave),
                            label: "Leave",
                            count: '0',
                            isActive:
                                tabBarCubit.state.index == 0 ? true : false,
                          );
                        },
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      BlocBuilder<MisspunchApprovedCubit,
                          MisspunchApprovedState>(
                        builder: (context, state) {
                          if (state is MisspunchApprovedLoaded) {
                            return _DashboardTopBarHeaderItem(
                              onPressed: () => tabBarCubit
                                  .getTabBarItem(DashboardTabItem.misspunch),
                              label: "Mispunch",
                              count: state.misspunch.misspunchApproved!.isEmpty
                                  ? "0"
                                  : state.misspunch.misspunchApproved!.length
                                      .toString(),
                              isActive:
                                  tabBarCubit.state.index == 1 ? true : false,
                            );
                          }
                          return _DashboardTopBarHeaderItem(
                            onPressed: () => tabBarCubit
                                .getTabBarItem(DashboardTabItem.misspunch),
                            label: "Mispunch",
                            count: '0',
                            isActive:
                                tabBarCubit.state.index == 1 ? true : false,
                          );
                        },
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      BlocBuilder<PermissionHistoryCubit,
                          PermissionHistoryState>(
                        builder: (context, state) {
                          if (state is PermissionHistoryLoaded) {
                            return _DashboardTopBarHeaderItem(
                              onPressed: () => tabBarCubit
                                  .getTabBarItem(DashboardTabItem.permission),
                              label: "Permission",
                              count: state.history.permissionList.isEmpty
                                  ? "0"
                                  : state.history.permissionList.length
                                      .toString(),
                              isActive:
                                  tabBarCubit.state.index == 2 ? true : false,
                            );
                          }
                          return _DashboardTopBarHeaderItem(
                            onPressed: () => tabBarCubit
                                .getTabBarItem(DashboardTabItem.permission),
                            label: "Permission",
                            count: '0',
                            isActive:
                                tabBarCubit.state.index == 2 ? true : false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Dimensions.kVerticalSpaceSmall,
                if (dashState.dashboardTab == DashboardTabItem.leave)
                  const Expanded(child: TodayLeaveWidget()),
                if (dashState.dashboardTab == DashboardTabItem.misspunch)
                  const Expanded(child: TodayMisspunchWidget()),
                if (dashState.dashboardTab == DashboardTabItem.permission)
                  const Expanded(child: TodayOdPermissionWidget()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DashboardTopBarHeaderItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String count;
  final bool isActive;

  const _DashboardTopBarHeaderItem(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.count,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        borderRadius: Dimensions.kBorderRadiusAllLarger,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6).w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? appColor.brand800 : appColor.white,
            borderRadius: Dimensions.kBorderRadiusAllLarger,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label,
                  style: context.textTheme.titleSmall?.copyWith(
                      fontSize: 12,
                      color: isActive ? appColor.white : appColor.gray700)),
              SizedBox(width: 4.w),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 1).w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: Dimensions.kBorderRadiusAllLarger,
                  color: appColor.error600,
                ),
                child: Text(count,
                    style: context.textTheme.titleSmall
                        ?.copyWith(fontSize: 8, color: appColor.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardAttendanceLog extends StatelessWidget {
  _DashboardAttendanceLog({super.key});

  final List<Map<String, dynamic>> dashboardReport = [
    {
      'icon': AppSvg.renewalTracking,
      'label': 'Renewal Tracking',
      'color': const Color(0xFF9F0000),
    },
    {
      'icon': AppSvg.attendance,
      'label': 'Present',
      'color': const Color(0xFF085D3A),
    },
    {
      'icon': AppSvg.foodFill,
      'label': 'Food Attendance',
      'color': const Color(0xFFE04F16),
    },
    {
      'icon': AppSvg.leave,
      'label': 'Leave',
      'color': const Color(0xFFCC7B03),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<DashboardCountCubit, DashboardCountState>(
        builder: (context, state) {
          if (state is DashboardCountLoaded) {
            final count = state.dashboardCount.counts;
            return Row(
              children: [
                for (var i = 0; i < dashboardReport.length; i++) ...[
                  dashboardReportLog(
                    context,
                    icon: dashboardReport[i]['icon'] ?? '',
                    label: dashboardReport[i]['label'] ?? '',
                    count: getDashboardCount(
                        dashboardReport[i]['label'] ?? '', count),
                    color: dashboardReport[i]['color'] ?? '',
                    model: count,
                  ),
                  i == 3
                      ? const SizedBox()
                      : Dimensions.kHorizontalSpaceSmaller,
                ]
              ],
            );
          }
          return Row(
            children: [
              for (var i = 0; i < dashboardReport.length; i++) ...[
                dashboardReportLog(
                  context,
                  icon: dashboardReport[i]['icon'] ?? '',
                  label: dashboardReport[i]['label'] ?? '',
                  count: '00',
                  color: appColor.gray400,
                  model: null,
                ),
                i == 3 ? const SizedBox() : Dimensions.kHorizontalSpaceSmaller,
              ]
            ],
          );
        },
      ),
    );
  }

  String getDashboardCount(String label, DashboardCount? count) {
    switch (label) {
      case 'Renewal Tracking':
        return (count!.renewalTracking ?? 0).toString();
      case 'Present':
        return (count!.present ?? 0).toString();
      case 'Food Attendance':
        return (count!.foodCount ?? 0).toString();
      case 'Leave':
        return (count!.leave ?? 0).toString();
    }
    return '0';
  }

  void gotoPage(BuildContext context, String label) {
    if (label == "Renewal Tracking") {
      Navigator.pushNamed(context, AppRouterPath.renewalTrackingScreen);
    }
    if (label == "Present") {
      Navigator.pushNamed(context, AppRouterPath.attendanceReport);
    }
    if (label == "Food Attendance") {
      Navigator.pushNamed(context, AppRouterPath.foodAttendanceReport);
    }
    if (label == "Leave") {
      BlocProvider.of<ApprovalLeaveHistoryCubit>(context).approvalLeaveHistory(
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          DateFormat('yyyy-MM-dd').format(DateTime.now()));
      Navigator.pushNamed(context, AppRouterPath.dashboardLeaveApprovalScreen);
    }
  }

  Widget dashboardReportLog(BuildContext context,
      {required String icon,
      required String label,
      required String count,
      required Color color,
      required DashboardCount? model}) {
    return SizedBox(
      width: 170.w,
      child: InkWell(
        onTap: () => gotoPage(context, label),
        borderRadius: BorderRadius.circular(8).w,
        child: Container(
          padding: Dimensions.kPaddingAllSmall,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).w,
            color: appColor.white,
            boxShadow: [
              BoxShadow(
                color: appColor.gray200.withOpacity(.2),
                offset: const Offset(0, 3),
                spreadRadius: 3,
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: Dimensions.kPaddingAllSmallest,
                child: SvgPicture.asset(
                  icon,
                  width: Dimensions.iconSizeMedium - 6,
                  colorFilter: ColorFilter.mode(
                    color,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.textTheme.titleSmall?.copyWith(
                        color: appColor.brand950, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2.h),
                  if (label == "Renewal Tracking")
                    RichText(
                      text: TextSpan(
                        style: context.textTheme.headlineMedium,
                        children: [
                          TextSpan(
                            text: "${model?.renewalActive ?? 0}",
                            style: context.textTheme.headlineMedium
                                ?.copyWith(color: appColor.success600),
                          ),
                          TextSpan(
                            text: " - ",
                            style: context.textTheme.headlineMedium
                                ?.copyWith(color: appColor.success600),
                          ),
                          TextSpan(
                            text: "${model?.renewalExpiry ?? 0}",
                            style: context.textTheme.headlineMedium
                                ?.copyWith(color: appColor.warning600),
                          ),
                          TextSpan(
                            text: " - ",
                            style: context.textTheme.headlineMedium
                                ?.copyWith(color: appColor.success600),
                          ),
                          TextSpan(
                            text: "${model?.renewalOverDue ?? 0}",
                            style: context.textTheme.headlineMedium
                                ?.copyWith(color: appColor.error600),
                          ),
                        ],
                      ),
                    ),
                  if (label != "Renewal Tracking")
                    Text(
                      count,
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: color,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskLeadDetailWidget extends StatelessWidget {
  final TaskLeadData task;

  const _TaskLeadDetailWidget({required this.task});

  Color getColor(String label) {
    switch (label.toUpperCase()) {
      case "INITIATED":
        return appColor.warning600;
      case "PENDING":
        return appColor.indigo600;
      case "IN PROGRESS":
        return appColor.fuchsia600;
      case "APPROVE":
        return appColor.success600;
      case "TESTING L1" || "TESTING L2":
        return appColor.grayBlue600;
      case "REJECT" || "REJECTED" || "CANCELLED":
        return appColor.error600;
    }
    return appColor.success600;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor(task.status ?? '');
    return Container(
      width: 300.w,
      padding: Dimensions.kPaddingAllSmall,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: BorderRadius.circular(8).w,
        border: Border.all(
            width: 1,
            color: color.withOpacity(.2),
            strokeAlign: BorderSide.strokeAlignCenter),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF5F5F5).withOpacity(.2),
            blurRadius: 12,
            offset: const Offset(0, 3),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leaveTag(
                context,
                label: (task.status ?? "").toUpperCase(),
                color: color,
              ),
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            'Project',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400, letterSpacing: .5, color: color),
          ),
          Text(
            task.projectName ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: context.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: .5),
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            'Task',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400, letterSpacing: .5, color: color),
          ),
          Text(
            task.task ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: context.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.w500, letterSpacing: .5),
          ),
          Dimensions.kSpacer,
          Dimensions.kVerticalSpaceSmaller,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Text('Task Date :',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold, color: color)),
              Dimensions.kHorizontalSpaceSmall,
              Text(task.taskDate ?? '',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          Dimensions.kVerticalSpaceSmallest,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Text('Target Date :',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold, color: color)),
              Dimensions.kHorizontalSpaceSmall,
              Text(task.targetDate ?? '',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.white,
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      border: Border.all(width: 1, color: appColor.gray400),
    );
  }

  Widget leaveTag(BuildContext context,
      {required Color color, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4).w,
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.w500, color: color),
      ),
    );
  }
}
