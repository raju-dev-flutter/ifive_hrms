import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchScreen extends StatefulWidget {
  const MisspunchScreen({super.key});

  @override
  State<MisspunchScreen> createState() => _MisspunchScreenState();
}

class _MisspunchScreenState extends State<MisspunchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime approvedFromDate = DateTime.now();
  DateTime approvedToDate = DateTime.now();

  DateTime historyFromDate = DateTime.now();
  DateTime historyToDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    BlocProvider.of<MisspunchHistoryCubit>(context).getMisspunchHistory(
        DateFormat('yyyy-MM-dd').format(historyFromDate),
        DateFormat('yyyy-MM-dd').format(historyToDate));

    BlocProvider.of<MisspunchApprovedCubit>(context).misspunchApproved(
        DateFormat('yyyy-MM-dd').format(approvedFromDate),
        DateFormat('yyyy-MM-dd').format(approvedToDate));
  }

  Future<void> refreshApprovedCallBack() async {
    BlocProvider.of<MisspunchApprovedCubit>(context).misspunchApproved(
        DateFormat('yyyy-MM-dd').format(approvedFromDate),
        DateFormat('yyyy-MM-dd').format(approvedToDate));
  }

  Future<void> refreshHistoryCallBack() async {
    BlocProvider.of<MisspunchHistoryCubit>(context).getMisspunchHistory(
        DateFormat('yyyy-MM-dd').format(historyFromDate),
        DateFormat('yyyy-MM-dd').format(historyToDate));
  }

  Future<void> refresh() async {
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
            title: "Misspunch",
            actions: [
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouterPath.misspunchRequest)
                        .then((value) => initialCallBack()),
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
                if (val == 0) refreshApprovedCallBack();
                if (val == 1) refreshHistoryCallBack();
              },
              tabs: const [Tab(text: 'REQUESTED'), Tab(text: 'HISTORY')],
            ),
          ),
        ),
        body: _buildBodyUI(),
      ),
    );
  }

  Widget _buildBodyUI() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [_requestedHistoryBodyUI(), _misspunchHistoryBodyUI()],
    );
  }

  Widget _requestedHistoryBodyUI() {
    return Column(
      children: [
        requestedFilterCardUI(),
        BlocConsumer<MisspunchApprovedCubit, MisspunchApprovedState>(
          listener: (context, state) {
            if (state is MisspunchApprovedFailed) {
              if (state.message == "Invalid Token") {
                BlocProvider.of<AuthenticationBloc>(context, listen: false)
                    .add(const LoggedOut());
              }
              if (state.message == "Network Error") {
                AppAlerts.displaySnackBar(context, state.message, false);
                // AppAlerts.displayErrorAlert(
                //     context, "Misspunch  Approval", state.message);
              }
            }
          },
          builder: (context, state) {
            if (state is MisspunchApprovedLoading) {
              return Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                          .w,
                  itemCount: 5,
                  itemBuilder: (_, i) {
                    return const MisspunchHistoryShimmerLoading();
                  },
                ),
              );
            }
            if (state is MisspunchApprovedLoaded) {
              if (state.misspunch.misspunchApproved!.isEmpty) {
                return Expanded(child: Lottie.asset(AppLottie.empty));
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                            .w,
                    itemCount: state.misspunch.misspunchApproved?.length,
                    itemBuilder: (_, i) {
                      final missPunch = state.misspunch.misspunchApproved![i];
                      return missPunchApprovedUI(
                          missPunch,
                          getColor(
                              state.misspunch.misspunchApproved![i].status ??
                                  ''));
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget _misspunchHistoryBodyUI() {
    return Column(
      children: [
        historyFilterCardUI(),
        BlocConsumer<MisspunchHistoryCubit, MisspunchHistoryState>(
          listener: (context, state) {
            if (state is MisspunchHistoryFailed) {
              if (state.message == "Invalid Token") {
                BlocProvider.of<AuthenticationBloc>(context, listen: false)
                    .add(const LoggedOut());
              }
              if (state.message == "Network Error") {
                AppAlerts.displaySnackBar(context, state.message, false);
                // AppAlerts.displayErrorAlert(
                //     context, "Misspunch History", state.message);
              }
            }
          },
          builder: (context, state) {
            if (state is MisspunchHistoryLoading) {
              return Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                          .w,
                  itemCount: 5,
                  itemBuilder: (_, i) {
                    return const MisspunchHistoryShimmerLoading();
                  },
                ),
              );
            }
            if (state is MisspunchHistoryLoaded) {
              if (state.misspunch.misspunchhistory!.isEmpty) {
                return Expanded(child: Lottie.asset(AppLottie.empty));
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                            .w,
                    itemCount: state.misspunch.misspunchhistory?.length,
                    itemBuilder: (_, i) {
                      final missPunch = state.misspunch.misspunchhistory![i];
                      return missPunchHistoryUI(
                          missPunch,
                          getColor(
                              state.misspunch.misspunchhistory![i].status ??
                                  ''));
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget requestedFilterCardUI() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2).w,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: approvedFromDate, startDate: null);
                setState(() => approvedFromDate = date);
                refreshApprovedCallBack();
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
                      DateFormat('dd-MM-yyyy').format(approvedFromDate),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray900,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter:
                          ColorFilter.mode(appColor.gray700, BlendMode.srcIn),
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
                    selectedDate: approvedToDate, startDate: null);
                setState(() => approvedToDate = date);
                refreshApprovedCallBack();
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
                      DateFormat('dd-MM-yyyy').format(approvedToDate),
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
            onTap: refreshApprovedCallBack,
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColor.brand900,
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

  Widget historyFilterCardUI() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2).w,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: historyFromDate, startDate: null);
                setState(() => historyFromDate = date);
                refreshHistoryCallBack();
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
                      DateFormat('dd-MM-yyyy').format(historyFromDate),
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
                    selectedDate: historyToDate, startDate: null);
                setState(() => historyToDate = date);
                refreshHistoryCallBack();
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
                      DateFormat('dd-MM-yyyy').format(historyToDate),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray900,
                        // fontSize: 8,
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
            onTap: refreshHistoryCallBack,
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColor.brand900,
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

  Widget missPunchHistoryUI(MisspunchHistory missPunch, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRouterPath.misspunchCancel,
                arguments: MisspunchCancelScreen(missPunch: missPunch))
            .then((value) => initialCallBack()),
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
                            missPunch.lookupCode ?? '',
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
      ),
    );
  }

  Widget missPunchApprovedUI(MisspunchApproved missPunch, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
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
      ),
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

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.gray50,
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      border: Border.all(width: 1, color: appColor.gray300),
    );
  }
}
