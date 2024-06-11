import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class ODPermissionScreen extends StatefulWidget {
  const ODPermissionScreen({super.key});

  @override
  State<ODPermissionScreen> createState() => _ODPermissionScreenState();
}

class _ODPermissionScreenState extends State<ODPermissionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<PermissionHistoryCubit>(context).getPermissionHistory();
    BlocProvider.of<PermissionApprovalCubit>(context).getPermissionApproval();
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
            title: "OD / Permission",
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.oDPermissionRequestScreen)
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
                if (val == 0) initialCallBack();
                if (val == 1) initialCallBack();
              },
              tabs: const [Tab(text: 'APPROVAL'), Tab(text: 'HISTORY')],
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
      children: [_odPermissionApprovedUI(), _odPermissionHistoryUI()],
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

  Widget _odPermissionApprovedUI() {
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
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
            itemCount: 5,
            itemBuilder: (_, i) => const LeaveShimmerLoading(),
          );
        }
        if (state is PermissionHistoryLoaded) {
          if (state.history.permissionList.isEmpty) {
            return Center(child: Lottie.asset(AppLottie.empty));
          }
          return RefreshIndicator(
            onRefresh: initialCallBack,
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
              itemCount: state.history.permissionList.length,
              itemBuilder: (_, i) {
                final permissionHistory = state.history.permissionList[i];

                return permissionHistoryCardUI(permissionHistory,
                    getColor(state.history.permissionList[i].status ?? ""));
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _odPermissionHistoryUI() {
    return BlocConsumer<PermissionApprovalCubit, PermissionApprovalState>(
      listener: (context, state) {
        if (state is PermissionApprovalFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
          }
          if (state.message == "Network Error") {
            AppAlerts.displayErrorAlert(
                context, "OD | Permission History", state.message);
          }
        }
      },
      builder: (context, state) {
        if (state is PermissionApprovalLoading) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
            itemCount: 5,
            itemBuilder: (_, i) {
              return const LeaveShimmerLoading();
            },
          );
        }
        if (state is PermissionApprovalLoaded) {
          if (state.history.odphistory!.isEmpty) {
            return Center(child: Lottie.asset(AppLottie.empty));
          }
          return RefreshIndicator(
            onRefresh: initialCallBack,
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
              itemCount: state.history.odphistory!.length,
              itemBuilder: (_, i) {
                final permissionHistory = state.history.odphistory![i];

                return permissionApprovalCardUI(permissionHistory,
                    getColor(state.history.odphistory![i].status ?? ""));
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget permissionHistoryCardUI(PermissionResponse permission, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
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

  Widget permissionApprovalCardUI(Odphistory permission, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
                context, AppRouterPath.oDPermissionCancelScreen,
                arguments: ODPermissionCancelScreen(permission: permission))
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
      ),
    );
  }
}
