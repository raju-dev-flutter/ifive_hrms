part of 'widget.dart';

class DashboardLeaveApprovalScreen extends StatefulWidget {
  const DashboardLeaveApprovalScreen({super.key});

  @override
  State<DashboardLeaveApprovalScreen> createState() =>
      _DashboardLeaveApprovalScreenState();
}

class _DashboardLeaveApprovalScreenState
    extends State<DashboardLeaveApprovalScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  Future<void> initialCallBack() async {
    BlocProvider.of<ApprovalLeaveHistoryCubit>(context).approvalLeaveHistory(
        DateFormat('yyyy-MM-dd').format(selectedFromDate),
        DateFormat('yyyy-MM-dd').format(selectedToDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Leave History",
        ),
      ),
      body: _buildBodyUI(),
    );
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

  Widget _buildBodyUI() {
    return Column(
      children: [
        filterCardUI(),
        Expanded(
          child:
              BlocBuilder<ApprovalLeaveHistoryCubit, ApprovalLeaveHistoryState>(
            builder: (context, state) {
              if (state is ApprovalLeaveHistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ApprovalLeaveHistoryLoaded) {
                final leave = state.approvalLeaveHistory.leaveApproval;
                if (leave!.isEmpty) {
                  return Center(child: Lottie.asset(AppLottie.empty));
                }
                return RefreshIndicator(
                  onRefresh: initialCallBack,
                  child: ListView.builder(
                    padding: Dimensions.kPaddingAllMedium,
                    physics: const BouncingScrollPhysics(),
                    itemCount: leave.length,
                    itemBuilder: (_, i) {
                      return leaveApprovedCardUI(
                          leave[i], getColor(leave[i].leaveStatus!));
                    },
                  ),
                );
              }
              if (state is ApprovalLeaveHistoryFailed) {}
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget filterCardUI() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2).w,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: selectedFromDate, startDate: null);
                setState(() => selectedFromDate = date);
                initialCallBack();
              },
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy').format(selectedFromDate),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray900,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter: ColorFilter.mode(
                        appColor.gray700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: selectedToDate, startDate: null);
                setState(() => selectedToDate = date);
                initialCallBack();
              },
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy').format(selectedToDate),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray900,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter: ColorFilter.mode(
                        appColor.gray700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          InkWell(
            onTap: initialCallBack,
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColor.brand600,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
              ),
              child: SvgPicture.asset(
                AppSvg.search,
                width: 14,
                colorFilter: ColorFilter.mode(
                  appColor.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveApprovedCardUI(LeaveApprovalList leave, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Container(
        width: context.deviceSize.width,
        padding: Dimensions.kPaddingAllMedium,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    leave.employeeName ?? '',
                    style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500, letterSpacing: .5),
                  ),
                ),
                leaveTag(label: leave.leaveStatus ?? "", color: color),
              ],
            ),
            Row(
              children: [
                Text(leave.leaveTypeName ?? '',
                    style: context.textTheme.labelMedium
                        ?.copyWith(letterSpacing: .8, color: appColor.gray700)),
                Dimensions.kHorizontalSpaceSmall,
                SizedBox(width: 10.w, child: Divider(color: appColor.gray700)),
                Dimensions.kHorizontalSpaceSmall,
                Text(leave.leaveModeName ?? '',
                    style: context.textTheme.labelMedium
                        ?.copyWith(letterSpacing: .8, color: appColor.gray700)),
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
                Text('LEAVE FROM :',
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold, color: color)),
                Dimensions.kHorizontalSpaceSmall,
                Text(leave.startDate ?? '',
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Dimensions.kHorizontalSpaceSmall,
                SizedBox(width: 10.w, child: Divider(color: appColor.gray700)),
                Dimensions.kHorizontalSpaceSmall,
                Text(leave.startDate ?? '',
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            Dimensions.kVerticalSpaceSmaller,
            Text(
              "\" ${leave.leaveReason ?? ''} \"",
              style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: .8),
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
