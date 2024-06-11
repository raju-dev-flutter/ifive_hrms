part of 'screen.dart';

class DashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;

  const DashboardScreen({super.key, required this.scaffold});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    super.initState();
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
                      DashboardAttendanceLog(),
                    ],
                  ),
                ),
                const DashboardCarouselSlider(),
                // Dimensions.kVerticalSpaceMedium,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).w,
                  child: Container(
                    width: context.deviceSize.width,
                    padding: Dimensions.kPaddingAllSmaller,
                    decoration: BoxDecoration(
                      color: appColor.white,
                      borderRadius: Dimensions.kBorderRadiusAllLarger,
                      boxShadow: [
                        BoxShadow(
                          color: appColor.gray200.withOpacity(.4),
                          offset: const Offset(0, 3),
                          spreadRadius: 3,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child:
                        BlocBuilder<DashboardTabBarCubit, DashboardTabBarState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            DashboardTopBarHeaderItem(
                              onPressed: () => tabBarCubit
                                  .getTabBarItem(DashboardTabItem.leave),
                              label: "Leave",
                              isActive:
                                  tabBarCubit.state.index == 0 ? true : false,
                            ),
                            Dimensions.kHorizontalSpaceSmaller,
                            DashboardTopBarHeaderItem(
                              onPressed: () => tabBarCubit
                                  .getTabBarItem(DashboardTabItem.misspunch),
                              label: "Mispunch",
                              isActive:
                                  tabBarCubit.state.index == 1 ? true : false,
                            ),
                            Dimensions.kHorizontalSpaceSmaller,
                            DashboardTopBarHeaderItem(
                              onPressed: () => tabBarCubit
                                  .getTabBarItem(DashboardTabItem.permission),
                              label: "Permission",
                              isActive:
                                  tabBarCubit.state.index == 2 ? true : false,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Dimensions.kVerticalSpaceSmall,
                BlocBuilder<DashboardTabBarCubit, DashboardTabBarState>(
                    builder: (context, state) {
                  if (state.dashboardTab == DashboardTabItem.leave) {
                    return const TodayLeaveWidget();
                  } else if (state.dashboardTab == DashboardTabItem.misspunch) {
                    return const TodayMisspunchWidget();
                  } else if (state.dashboardTab ==
                      DashboardTabItem.permission) {
                    return const TodayOdPermissionWidget();
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardTopBarHeaderItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isActive;

  const DashboardTopBarHeaderItem(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        borderRadius: Dimensions.kBorderRadiusAllLarger,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? appColor.brand800 : appColor.gray100,
            borderRadius: Dimensions.kBorderRadiusAllLarger,
          ),
          child: Text(label,
              style: context.textTheme.titleSmall?.copyWith(
                  color: isActive ? appColor.white : appColor.gray700)),
        ),
      ),
    );
  }
}

class DashboardAttendanceLog extends StatelessWidget {
  DashboardAttendanceLog({super.key});

  final List<Map<String, dynamic>> dashboardReport = [
    {
      'icon': AppSvg.attendance,
      'label': 'Present',
      'color': const Color(0XFF085D3A),
    },
    {
      'icon': AppSvg.foodFill,
      'label': 'Food Attendance',
      'color': const Color(0XFFE04F16),
    },
    {
      'icon': AppSvg.leave,
      'label': 'Leave',
      'color': const Color(0XFF912018),
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
    if (label == "Present") {
      Navigator.pushNamed(context, AppRouterPath.attendanceReport);
    }
    if (label == "Food Attendance") {
      Navigator.pushNamed(context, AppRouterPath.foodAttendanceReport);
    }
    if (label == "Leave") {
      BlocProvider.of<ApprovalLeaveHistoryCubit>(context).approvalLeaveHistory(
          DateFormat('yyyy-MM-dd').format(DateTime.now()));
      Navigator.pushNamed(context, AppRouterPath.dashboardLeaveApprovalScreen);
    }
  }

  Widget dashboardReportLog(BuildContext context,
      {required String icon,
      required String label,
      required String count,
      required Color color}) {
    return SizedBox(
      width: 160.w,
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
                padding: const EdgeInsets.all(6).w,
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
