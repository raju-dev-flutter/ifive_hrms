part of 'widget.dart';

class TodayOdPermissionWidget extends StatefulWidget {
  const TodayOdPermissionWidget({super.key});

  @override
  State<TodayOdPermissionWidget> createState() =>
      _TodayOdPermissionWidgetState();
}

class _TodayOdPermissionWidgetState extends State<TodayOdPermissionWidget> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  Color getColor(String label) {
    switch (label) {
      case "INITIATED":
        return appColor.warning600;
      case "APPROVE":
        return appColor.success600;
      case "REJECT" || "REJECTED" || "CANCELLED":
        return appColor.error600;
    }

    return appColor.success600;
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<PermissionHistoryCubit>(context).getPermissionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyUI();
  }

  Widget _buildBodyUI() {
    return BlocConsumer<PermissionHistoryCubit, PermissionHistoryState>(
      listener: (context, state) {
        if (state is PermissionHistoryFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
          }
          if (state.message == "Network Error") {
            AppAlerts.displayErrorAlert(
                context, "OD | Permission Approval", state.message);
          }
        }
      },
      builder: (context, state) {
        if (state is PermissionHistoryLoading) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 0).w,
            itemCount: 5,
            itemBuilder: (_, i) => const LeaveShimmerLoading(),
            separatorBuilder: (_, i) {
              return Dimensions.kVerticalSpaceSmaller;
            },
          );
        }
        if (state is PermissionHistoryLoaded) {
          if (state.history.permissionList.isEmpty) {
            return Center(child: Lottie.asset(AppLottie.empty, width: 250.w));
          }
          return ListView.separated(
            padding: const EdgeInsets.only(top: 0).w,
            itemCount: state.history.permissionList.length,
            itemBuilder: (_, i) {
              final permissionHistory = state.history.permissionList[i];

              return permissionApprovalCardUI(permissionHistory,
                  getColor(state.history.permissionList[i].status ?? ""));
            },
            separatorBuilder: (_, i) {
              return Dimensions.kVerticalSpaceSmaller;
            },
          );
        }
        return Container();
      },
    );
  }

  Widget permissionApprovalCardUI(PermissionResponse permission, Color color) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
              context, AppRouterPath.oDPermissionUpdateScreen,
              arguments: ODPermissionUpdateScreen(permission: permission))
          .then((value) => initialCallBack()),
      borderRadius: BorderRadius.circular(8).w,
      child: Container(
        decoration: BoxDecoration(
          color: appColor.white,
          borderRadius: BorderRadius.circular(8).w,
          border: Border(left: BorderSide(width: 5, color: color)),
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
          children: [
            Container(
              width: context.deviceSize.width,
              padding: Dimensions.kPaddingAllMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          permission.username ?? '',
                          style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500, letterSpacing: .5),
                        ),
                      ),
                      leaveTag(
                        label: permission.status ?? "",
                        color: color,
                      ),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppSvg.calendar,
                        width: 16,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      Text('DATE :',
                          style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold, color: color)),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(permission.date ?? '',
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Dimensions.kHorizontalSpaceSmall,
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppSvg.time,
                        width: 16,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      Text('TIME :',
                          style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold, color: color)),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(
                          permission.inTime == null
                              ? ' '
                              : permission.inTime!.split(' ').last,
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Dimensions.kHorizontalSpaceSmall,
                      SizedBox(
                        width: permission.outTime == null ? 0 : 10.w,
                        child: Divider(color: appColor.error600),
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(
                          permission.outTime == null
                              ? ' '
                              : permission.outTime!.split(' ').last,
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text("\" ${permission.reason ?? ''} \"",
                      style: context.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          letterSpacing: .8)),
                ],
              ),
            ),
          ],
        ),
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

  Widget leaveTag({required Color color, required String label}) {
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
