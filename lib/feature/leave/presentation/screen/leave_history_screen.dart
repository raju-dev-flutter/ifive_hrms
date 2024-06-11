import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    BlocProvider.of<LeaveHistoryCubit>(context).getLeaveHistory();
    // BlocProvider.of<LeaveApprovedCubit>(context).getLeaveApproved(
    //     DateFormat('yyyy-MM-dd').format(selectedFromDate),
    //     DateFormat('yyyy-MM-dd').format(selectedToDate));
  }

  Future<void> refreshHistoryCallBack() async {
    BlocProvider.of<LeaveHistoryCubit>(context).getLeaveHistory();
  }

  // Future<void> refreshApprovedCallBack() async {
  //   BlocProvider.of<LeaveApprovedCubit>(context).getLeaveApproved(
  //       DateFormat('yyyy-MM-dd').format(selectedFromDate),
  //       DateFormat('yyyy-MM-dd').format(selectedToDate));
  // }

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
  //
  // @override
  // Widget build(BuildContext context) {
  //   return
  //       // DefaultTabController(
  //       // length: 2,
  //       // child:
  //       Scaffold(
  //     key: _scaffoldKey,
  //     backgroundColor: appColor.gray100,
  //     appBar: PreferredSize(
  //       preferredSize: Size(context.deviceSize.width, 90.h),
  //       child: CustomAppBar(
  //         onPressed: () => Navigator.pop(context),
  //         title: "Leave",
  //         actions: [
  //           IconButton(
  //             onPressed: () =>
  //                 Navigator.pushNamed(context, AppRouterPath.leaveRequest)
  //                     .then((value) => initialCallBack()),
  //             icon: Icon(Icons.add, color: appColor.gray900),
  //           ),
  //         ],
  //         // bottom: TabBar(
  //         //   indicatorPadding: const EdgeInsets.all(0).w,
  //         //   labelPadding: const EdgeInsets.all(0).w,
  //         //   unselectedLabelColor: appColor.gray700,
  //         //   unselectedLabelStyle: context.textTheme.labelLarge
  //         //       ?.copyWith(fontWeight: FontWeight.bold),
  //         //   labelStyle: context.textTheme.labelLarge
  //         //       ?.copyWith(fontWeight: FontWeight.bold),
  //         //   isScrollable: false,
  //         //   onTap: (val) {
  //         //     if (val == 0) refreshApprovedCallBack();
  //         //     if (val == 1) refreshHistoryCallBack();
  //         //   },
  //         //   tabs: const [Tab(text: 'APPROVAL'), Tab(text: 'HISTORY')],
  //         // ),
  //       ),
  //     ),
  //     body: _buildBodyUI(),
  //     // ),
  //   );
  // }

  // Widget _buildBodyUI() {
  //   return _leaveHistoryUI();
  // }

  Widget _buildBodyUI() {
    return BlocConsumer<LeaveHistoryCubit, LeaveHistoryState>(
      listener: (context, state) {
        if (state is LeaveHistoryFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
          }
          if (state.message == "Network Error") {
            AppAlerts.displaySnackBar(context, state.message, false);
            // AppAlerts.displayErrorAlert(
            //     context, "Leave History", state.message);
          }
        }
      },
      builder: (context, state) {
        if (state is LeaveHistoryLoading) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
            itemCount: 5,
            itemBuilder: (_, i) {
              return const LeaveShimmerLoading();
            },
          );
        }
        if (state is LeaveHistoryLoaded) {
          if (state.history.leavehistory!.isEmpty) {
            return Center(child: Lottie.asset(AppLottie.empty));
          }
          return RefreshIndicator(
            onRefresh: refreshHistoryCallBack,
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
              itemCount: state.history.leavehistory?.length,
              itemBuilder: (_, i) {
                final leaveHistory = state.history.leavehistory![i];

                return leaveHistoryCardUI(leaveHistory,
                    getColor(state.history.leavehistory![i].leaveStatus ?? ""));
              },
            ),
          );
        }
        if (state is LeaveHistoryFailed) {}
        return Container();
      },
    );
  }

  // Widget _leaveApprovedUI() {
  //   return Column(
  //     children: [
  //       filterCardUI(),
  //       BlocConsumer<LeaveApprovedCubit, LeaveApprovedState>(
  //         listener: (context, state) {
  //           if (state is LeaveApprovedFailed) {
  //             if (state.message == "Invalid Token") {
  //               BlocProvider.of<AuthenticationBloc>(context, listen: false)
  //                   .add(const LoggedOut());
  //             }
  //             if (state.message == "Network Error") {
  //               AppAlerts.displaySnackBar(context, state.message, false);
  //               // AppAlerts.displayErrorAlert(
  //               //     context, "Leave Approval", state.message);
  //             }
  //           }
  //         },
  //         builder: (context, state) {
  //           if (state is LeaveApprovedLoading) {
  //             return Expanded(
  //               child: ListView.builder(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
  //                         .w,
  //                 itemCount: 5,
  //                 itemBuilder: (_, i) {
  //                   return const LeaveShimmerLoading();
  //                 },
  //               ),
  //             );
  //           }
  //           if (state is LeaveApprovedLoaded) {
  //             if (state.approved.leavelist!.isEmpty) {
  //               return Expanded(child: Lottie.asset(AppLottie.empty));
  //             }
  //             return Expanded(
  //               child: RefreshIndicator(
  //                 onRefresh: refreshApprovedCallBack,
  //                 child: ListView.builder(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
  //                           .w,
  //                   itemCount: state.approved.leavelist?.length,
  //                   itemBuilder: (_, i) {
  //                     return leaveApprovedCardUI(
  //                         state.approved.leavelist![i],
  //                         getColor(
  //                             state.approved.leavelist![i].leaveStatus ?? ""));
  //                   },
  //                 ),
  //               ),
  //             );
  //           }
  //           if (state is LeaveHistoryFailed) {}
  //           return Container();
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget leaveHistoryCardUI(Leavehistory leave, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRouterPath.leaveCancel,
                arguments: LeaveCancelScreen(leave: leave))
            .then((value) => initialCallBack()),
        borderRadius: BorderRadius.circular(8).w,
        child: Container(
          decoration: BoxDecoration(
            color: appColor.gray50,
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
                                letterSpacing: .8, color: appColor.gray300)),
                        Dimensions.kHorizontalSpaceSmall,
                        SizedBox(
                          width: 10.w,
                          child: Divider(color: appColor.gray300),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Text(leave.leavemode ?? '',
                            style: context.textTheme.labelMedium?.copyWith(
                                letterSpacing: .8, color: appColor.gray300)),
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
                            style: context.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold, color: color)),
                        Dimensions.kHorizontalSpaceSmall,
                        Text(leave.startDate ?? '',
                            style: context.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Dimensions.kHorizontalSpaceSmall,
                        SizedBox(
                          width: 10.w,
                          child: Divider(color: appColor.brand50),
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
      ),
    );
  }

  // Widget filterCardUI() {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2).w,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: InkWell(
  //             onTap: () async {
  //               DateTime date = await PickDateTime.date(context,
  //                   selectedDate: selectedFromDate, startDate: null);
  //               setState(() => selectedFromDate = date);
  //               refreshApprovedCallBack();
  //             },
  //             borderRadius: Dimensions.kBorderRadiusAllSmallest,
  //             child: Container(
  //               height: 42,
  //               alignment: Alignment.center,
  //               padding: const EdgeInsets.symmetric(horizontal: 12),
  //               decoration: boxDecoration(),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     DateFormat('dd-MM-yyyy').format(selectedFromDate),
  //                     style: context.textTheme.labelMedium?.copyWith(
  //                       fontWeight: FontWeight.w400,
  //                       color: appColor.gray900,
  //                     ),
  //                   ),
  //                   SvgPicture.asset(
  //                     AppSvg.calendar,
  //                     width: 14.w,
  //                     colorFilter: ColorFilter.mode(
  //                       appColor.gray700,
  //                       BlendMode.srcIn,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 4.w),
  //         Expanded(
  //           flex: 2,
  //           child: InkWell(
  //             onTap: () async {
  //               DateTime date = await PickDateTime.date(context,
  //                   selectedDate: selectedToDate, startDate: null);
  //               setState(() => selectedToDate = date);
  //               refreshApprovedCallBack();
  //             },
  //             borderRadius: Dimensions.kBorderRadiusAllSmallest,
  //             child: Container(
  //               height: 42,
  //               alignment: Alignment.center,
  //               padding: const EdgeInsets.symmetric(horizontal: 12),
  //               decoration: boxDecoration(),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     DateFormat('dd-MM-yyyy').format(selectedToDate),
  //                     style: context.textTheme.labelMedium?.copyWith(
  //                       fontWeight: FontWeight.w400,
  //                       color: appColor.gray900,
  //                       // fontSize: 8,
  //                     ),
  //                   ),
  //                   SvgPicture.asset(
  //                     AppSvg.calendar,
  //                     width: 14.w,
  //                     colorFilter: ColorFilter.mode(
  //                       appColor.gray700,
  //                       BlendMode.srcIn,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 4.w),
  //         InkWell(
  //           onTap: refreshApprovedCallBack,
  //           borderRadius: Dimensions.kBorderRadiusAllSmallest,
  //           child: Container(
  //             width: 38,
  //             height: 38,
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               color: appColor.brand900,
  //               borderRadius: Dimensions.kBorderRadiusAllSmallest,
  //             ),
  //             child: SvgPicture.asset(
  //               AppSvg.search,
  //               width: 14,
  //               colorFilter: ColorFilter.mode(
  //                 appColor.white,
  //                 BlendMode.srcIn,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget leaveApprovedCardUI(Leavelist leave, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRouterPath.leaveUpdate,
                arguments: LeaveUpdateScreen(leave: leave))
            .then((value) => initialCallBack()),
        child: Container(
          decoration: BoxDecoration(
            color: appColor.gray50,
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
                                letterSpacing: .8, color: appColor.gray300)),
                        Dimensions.kHorizontalSpaceSmall,
                        SizedBox(
                          width: 10.w,
                          child: Divider(color: appColor.gray300),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Text(leave.leavemode ?? '',
                            style: context.textTheme.labelMedium?.copyWith(
                                letterSpacing: .8, color: appColor.gray300)),
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
                            style: context.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold, color: color)),
                        Dimensions.kHorizontalSpaceSmall,
                        Text(leave.startDate ?? '',
                            style: context.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Dimensions.kHorizontalSpaceSmall,
                        SizedBox(
                          width: 10.w,
                          child: Divider(color: appColor.gray300),
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
