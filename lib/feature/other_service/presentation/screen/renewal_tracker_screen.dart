import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../other_service.dart';

class RenewalTrackingScreen extends StatefulWidget {
  const RenewalTrackingScreen({super.key});

  @override
  State<RenewalTrackingScreen> createState() => _RenewalTrackingScreenState();
}

class _RenewalTrackingScreenState extends State<RenewalTrackingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<RenewalTrackerCubit>(context)
        .renewalTracking(status: "All");
  }

  Future<void> onTapCallBack(String status) async {
    BlocProvider.of<RenewalTrackerCubit>(context)
        .renewalTracking(status: status);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: appColor.gray50,
        appBar: PreferredSize(
          preferredSize: Size(context.deviceSize.width, 84.h),
          child: CustomAppBar(
            onPressed: () => Navigator.pop(context),
            title: "Renewal Tracking",
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
                if (val == 0) onTapCallBack("All");
                if (val == 1) onTapCallBack("ACTIVE");
                if (val == 2) onTapCallBack("EXPIRY");
                if (val == 3) onTapCallBack("OVER DUE");
              },
              tabs: const [
                Tab(text: 'ALL'),
                Tab(text: 'ACTIVE'),
                Tab(text: 'EXPIRY'),
                Tab(text: 'OVER DUE'),
              ],
            ),
          ),
        ),
        body: _buildBodyUI(),
      ),
    );
  }

  Widget _buildBodyUI() {
    return BlocBuilder<RenewalTrackerCubit, RenewalTrackerState>(
      builder: (context, state) {
        if (state is RenewalTrackerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RenewalTrackerLoaded) {
          final renewalTracker = state.renewalTracker.renewalTracker!;
          if (renewalTracker.isEmpty) {
            return Center(child: Lottie.asset(AppLottie.empty));
          }
          return RefreshIndicator(
            onRefresh: initialCallBack,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: Dimensions.kPaddingAllMedium,
              itemCount: renewalTracker.length,
              itemBuilder: (_, i) {
                return renewalTrackingDetailCard(renewalTracker[i]);
              },
              separatorBuilder: (_, i) {
                return Dimensions.kVerticalSpaceSmaller;
              },
            ),
          );
        }

        return Container();
      },
    );
  }

  Color getColor(label) {
    switch (label) {
      case 'Complied':
        return appColor.blue600;
      case 'Action Needed':
        return appColor.warning600;
      case 'Over Due':
        return appColor.error600;
    }
    return appColor.blue600;
  }

  Widget renewalTrackingDetailCard(RenewalTracker renewalTracker) {
    return Container(
      padding: Dimensions.kPaddingAllSmall,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
        border: Border(
            left: BorderSide(
                width: 5, color: getColor(renewalTracker.status ?? ''))),
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
          Row(children: [
            Expanded(
              child: Text("\" ${renewalTracker.nameOfDoc ?? ''} \"",
                  style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: getColor(renewalTracker.status ?? ''),
                      fontStyle: FontStyle.italic,
                      letterSpacing: .8)),
            ),
            // Dimensions.kSpacer,
            Dimensions.kHorizontalSpaceSmaller,
            Container(
              padding: Dimensions.kPaddingAllSmaller,
              decoration: BoxDecoration(
                color: getColor(renewalTracker.status ?? '').withOpacity(.1),
                borderRadius: Dimensions.kBorderRadiusAllSmaller,
              ),
              child: Text(
                renewalTracker.status ?? '',
                style: context.textTheme.labelMedium?.copyWith(
                    color: getColor(renewalTracker.status ?? ''),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          Dimensions.kVerticalSpaceSmaller,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                colorFilter: ColorFilter.mode(
                    getColor(renewalTracker.status ?? ''), BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Text('Due Date :',
                  style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: getColor(renewalTracker.status ?? ''))),
              Dimensions.kHorizontalSpaceSmall,
              Text(renewalTracker.dueDate ?? '',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                colorFilter: ColorFilter.mode(
                    getColor(renewalTracker.status ?? ''), BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Text('Till Date :',
                  style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: getColor(renewalTracker.status ?? ''))),
              Dimensions.kHorizontalSpaceSmall,
              Text(renewalTracker.validTill ?? '',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          Dimensions.kVerticalSpaceSmall,
          Dimensions.kDivider,
          Dimensions.kVerticalSpaceSmaller,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.accountFill,
                width: 12.w,
                colorFilter: ColorFilter.mode(
                    getColor(renewalTracker.status ?? ''), BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmall,
              Text(renewalTracker.departmentName ?? '',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          // Dimensions.kVerticalSpaceSmaller,
          // Text("\" ${renewalTracker.nameOfDoc ?? ''} \"",
          //     style: context.textTheme.labelLarge?.copyWith(
          //         fontWeight: FontWeight.bold,
          //         fontStyle: FontStyle.italic,
          //         letterSpacing: .8)),
        ],
      ),
    );
  }
}
