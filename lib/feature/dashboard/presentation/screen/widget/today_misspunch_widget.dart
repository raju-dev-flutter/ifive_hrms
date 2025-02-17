part of 'widget.dart';

class TodayMisspunchWidget extends StatefulWidget {
  const TodayMisspunchWidget({super.key});

  @override
  State<TodayMisspunchWidget> createState() => _TodayMisspunchWidgetState();
}

class _TodayMisspunchWidgetState extends State<TodayMisspunchWidget> {
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
    BlocProvider.of<MisspunchApprovedCubit>(context).misspunchApproved(
        DateFormat('yyyy-MM-dd').format(selectedFromDate),
        DateFormat('yyyy-MM-dd').format(selectedToDate));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyUI();
  }

  Widget _buildBodyUI() {
    return BlocConsumer<MisspunchApprovedCubit, MisspunchApprovedState>(
      listener: (context, state) {
        if (state is MisspunchApprovedFailed) {
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
        if (state is MisspunchApprovedLoading) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 0).w,
            itemCount: 5,
            itemBuilder: (_, i) {
              return const MisspunchHistoryShimmerLoading();
            },
            separatorBuilder: (_, i) {
              return Dimensions.kVerticalSpaceSmaller;
            },
          );
        }
        if (state is MisspunchApprovedLoaded) {
          if (state.misspunch.misspunchApproved!.isEmpty) {
            return Lottie.asset(AppLottie.empty, width: 250.w);
          }
          return ListView.separated(
            padding: const EdgeInsets.only(top: 0).w,
            itemCount: state.misspunch.misspunchApproved!.length,
            itemBuilder: (_, i) {
              final missPunch = state.misspunch.misspunchApproved![i];
              return missPunchApprovedUI(missPunch,
                  getColor(state.misspunch.misspunchApproved![i].status ?? ''));
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

  Widget missPunchApprovedUI(MisspunchApproved missPunch, Color color) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRouterPath.misspunchUpdate,
              arguments: MisspunchUpdateScreen(missPunch: missPunch))
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
                          missPunch.username ?? '',
                          style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500, letterSpacing: .5),
                        ),
                      ),
                      leaveTag(
                        label: missPunch.status ?? "",
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
                      Text(missPunch.date ?? '',
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
                          missPunch.time == null ||
                                  missPunch.time == "0000-00-00 00:00:00"
                              ? ' '
                              : missPunch.time!.split(' ').last,
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      missPunch.inTime == null ||
                              missPunch.inTime == "0000-00-00 00:00:00" ||
                              missPunch.time == null ||
                              missPunch.time == "0000-00-00 00:00:00"
                          ? const SizedBox()
                          : Dimensions.kHorizontalSpaceSmaller,
                      SizedBox(
                        width: missPunch.inTime == null ||
                                missPunch.inTime == "0000-00-00 00:00:00" ||
                                missPunch.time == null ||
                                missPunch.time == "0000-00-00 00:00:00"
                            ? 0
                            : 10.w,
                        child: Divider(color: appColor.error600),
                      ),
                      missPunch.inTime == null ||
                              missPunch.inTime == "0000-00-00 00:00:00" ||
                              missPunch.time == null ||
                              missPunch.time == "0000-00-00 00:00:00"
                          ? const SizedBox()
                          : Dimensions.kHorizontalSpaceSmall,
                      Text(
                          missPunch.inTime == null ||
                                  missPunch.inTime == "0000-00-00 00:00:00"
                              ? ' '
                              : missPunch.inTime!.split(' ').last,
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Dimensions.kHorizontalSpaceSmall,
                      SizedBox(
                        width: missPunch.outTime == null ||
                                missPunch.outTime == "0000-00-00 00:00:00"
                            ? 0
                            : 10.w,
                        child: Divider(color: appColor.error600),
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(
                          missPunch.outTime == null ||
                                  missPunch.outTime == "0000-00-00 00:00:00"
                              ? ' '
                              : missPunch.outTime!.split(' ').last,
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text("\" ${missPunch.reason ?? ''} \"",
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
