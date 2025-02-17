part of 'widget.dart';

class TodayLeaveWidget extends StatefulWidget {
  const TodayLeaveWidget({super.key});

  @override
  State<TodayLeaveWidget> createState() => _TodayLeaveWidgetState();
}

class _TodayLeaveWidgetState extends State<TodayLeaveWidget> {
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
      case "REJECT":
        return appColor.error600;
      case "CANCELLED":
        return appColor.error600;
    }

    return appColor.success600;
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<LeaveApprovedCubit>(context).getLeaveApproved(
        DateFormat('yyyy-MM-dd').format(selectedFromDate),
        DateFormat('yyyy-MM-dd').format(selectedToDate));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyUI();
  }

  Widget _buildBodyUI() {
    return BlocConsumer<LeaveApprovedCubit, LeaveApprovedState>(
      listener: (context, state) {
        if (state is LeaveApprovedFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
          }
          if (state.message == "Network Error") {
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        }
      },
      builder: (context, state) {
        if (state is LeaveApprovedLoading) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 0).w,
            itemCount: 5,
            itemBuilder: (_, i) {
              return const LeaveShimmerLoading();
            },
            separatorBuilder: (_, i) {
              return Dimensions.kVerticalSpaceSmaller;
            },
          );
        }
        if (state is LeaveApprovedLoaded) {
          if (state.approved.leavelist!.isEmpty) {
            return Lottie.asset(AppLottie.empty, width: 250.w);
          }
          return ListView.separated(
            padding: const EdgeInsets.only(top: 0).w,
            itemCount: state.approved.leavelist!.length,
            itemBuilder: (_, i) {
              return leaveApprovedCardUI(state.approved.leavelist![i],
                  getColor(state.approved.leavelist![i].leaveStatus ?? ""));
            },
            separatorBuilder: (_, i) {
              return Dimensions.kVerticalSpaceSmaller;
            },
          );
        }
        if (state is LeaveHistoryFailed) {}
        return Container();
      },
    );
  }

  Widget leaveApprovedCardUI(Leavelist leave, Color color) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRouterPath.leaveUpdate,
              arguments: LeaveUpdateScreen(leave: leave))
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          leave.username ?? '',
                          style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500, letterSpacing: .5),
                        ),
                      ),
                      leaveTag(
                        label: leave.leaveStatus ?? "",
                        color: color,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(leave.lookupMeaning ?? '',
                          style: context.textTheme.labelMedium?.copyWith(
                              letterSpacing: .8, color: appColor.gray700)),
                      Dimensions.kHorizontalSpaceSmall,
                      SizedBox(
                        width: 10.w,
                        child: Divider(color: appColor.gray700),
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(leave.leavemode ?? '',
                          style: context.textTheme.labelMedium?.copyWith(
                              letterSpacing: .8, color: appColor.gray700)),
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
                      // Dimensions.kHorizontalSpaceSmaller,
                      // Text('LEAVE FROM :',
                      //     style: context.textTheme.labelMedium?.copyWith(
                      //         fontWeight: FontWeight.bold, color: color)),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(leave.startDate ?? '',
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Dimensions.kHorizontalSpaceSmall,
                      SizedBox(
                        width: 10.w,
                        child: Divider(color: appColor.gray700),
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(leave.startDate ?? '',
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text("\" ${leave.leaveReason ?? ''} \"",
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
