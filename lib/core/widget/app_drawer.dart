import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../app/app.dart';
import '../../config/config.dart';
import '../../feature/feature.dart';
import '../core.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final methodChannel = const MethodChannel(AppKeys.methodChannel);

  void alarmStop() async {
    try {
      await methodChannel.invokeMethod("alarm_stop", <String, dynamic>{});
    } catch (e) {
      Logger().e("Error while accessing native call");
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   initialCallBack();
  // }
  //
  // void initialCallBack() {
  //   BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appColor.white,
      shape: const BeveledRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appDrawerHeaderUI(),
          Dimensions.kVerticalSpaceSmall,
          appDrawerMenu(),
          // Dimensions.kSpacer,
          Divider(color: appColor.blue600.withOpacity(.3)),
          GestureDetector(
            onTap: () {
              alarmStop();
              BlocProvider.of<AuthenticationBloc>(context, listen: false)
                  .add(const LoggedOut());
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8).w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, color: appColor.error600),
                  Dimensions.kHorizontalSpaceMedium,
                  Text(
                    "Logout",
                    style: context.textTheme.titleMedium
                        ?.copyWith(color: appColor.error600),
                  ),
                ],
              ),
            ),
          ),
          Dimensions.kVerticalSpaceSmall,
          poweredByWidget(),
          Dimensions.kVerticalSpaceMedium,
        ],
      ),
    );
  }

  Widget appDrawerHeaderUI() {
    return Container(
      width: context.deviceSize.width,
      padding: Dimensions.kPaddingAllMedium,
      color: appColor.brand800,
      child: BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
        builder: (context, state) {
          if (state is AccountDetailsLoading) {
            return ShimmerWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 46.h),
                  Container(
                    width: 60.w,
                    height: 60.h,
                    padding: Dimensions.kPaddingAllMedium,
                    decoration: BoxDecoration(
                      color: appColor.white,
                      borderRadius: Dimensions.kBorderRadiusAllLargest,
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Name", style: context.textTheme.titleLarge),
                      SizedBox(height: 3.h),
                      Text("User Email", style: context.textTheme.labelMedium),
                    ],
                  ),
                ],
              ),
            );
          }
          if (state is AccountDetailsLoaded) {
            final profile = state.profile.profile!;
            final isCheckImageEmpty = profile.avatar != "" &&
                profile.avatar != "null" &&
                profile.avatar != null;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 46.h),
                Container(
                  width: 60.w,
                  height: 60.h,
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(
                    color: isCheckImageEmpty ? null : appColor.white,
                    borderRadius: Dimensions.kBorderRadiusAllLargest,
                    border: Border.all(
                      color: appColor.white,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    image: isCheckImageEmpty
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            image: NetworkImage(
                                "${ApiUrl.baseUrl}public/${profile.avatar}"))
                        : null,
                  ),
                  child: isCheckImageEmpty
                      ? null
                      : SvgPicture.asset(
                          AppSvg.accountFill,
                          colorFilter: ColorFilter.mode(
                              appColor.brand800, BlendMode.srcIn),
                        ),
                ),
                Dimensions.kVerticalSpaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${profile.firstName ?? ""} ${profile.lastName ?? ""}",
                      style: context.textTheme.titleLarge
                          ?.copyWith(color: appColor.white),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      profile.email ?? "",
                      style: context.textTheme.labelMedium
                          ?.copyWith(color: appColor.white),
                    ),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget appDrawerMenu() {
    return Expanded(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        padding: const EdgeInsets.all(0),
        children: [
          /// Available Feature
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
            child: Text("Services",
                style: context.textTheme.labelLarge?.copyWith(
                    color: appColor.brand800, fontWeight: FontWeight.w600)),
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.attendance)
            },
            icon: AppSvg.attendance,
            label: 'Attendance',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.attendanceReport)
            },
            icon: AppSvg.attendance,
            label: 'Attendance Report',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.foodAttendance)
            },
            icon: AppSvg.foodFill,
            label: 'Food Attendance',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.misspunch)
            },
            icon: AppSvg.missPunch,
            label: 'Misspunch',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.oDPermissionScreen)
            },
            icon: AppSvg.calendar,
            label: 'OD | Permission',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.payrollScreen)
            },
            icon: AppSvg.payroll,
            label: 'Payroll',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.expensesScreen)
            },
            icon: AppSvg.asset,
            label: 'Expenses',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.appreciationScreen)
            },
            width: 20.w,
            icon: AppSvg.appreciation,
            label: 'Appreciation',
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.renewalTrackingScreen)
            },
            width: 20.w,
            icon: AppSvg.renewalTracking,
            label: 'Renewal Tracking',
          ),
          Dimensions.kVerticalSpaceSmaller,

          /// Additional Feature
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
            child: Text("Settings",
                style: context.textTheme.labelLarge?.copyWith(
                    color: appColor.brand800, fontWeight: FontWeight.w600)),
          ),
          appDrawerMenuButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, AppRouterPath.changePasswordScreen)
            },
            icon: AppSvg.changePassword,
            width: 22.w,
            label: 'Change Password',
          ),
        ],
      ),
    );
  }

  Widget poweredByWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Powered by: ', style: context.textTheme.labelSmall),
        const Image(image: AssetImage(AppIcon.ifiveLogo), width: 20),
        SizedBox(width: 4.w),
        Text('IFive Technology Pvt Ltd.', style: context.textTheme.labelSmall),
      ],
    );
  }

  Widget appDrawerMenuButton(
      {required String label,
      required String icon,
      double? width,
      required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: width ?? 18.w,
              colorFilter: ColorFilter.mode(appColor.gray700, BlendMode.srcIn),
            ),
            Dimensions.kHorizontalSpaceMedium,
            Text(label,
                style: context.textTheme.labelLarge?.copyWith(
                    color: appColor.gray700, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
