import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

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
        padding: Dimensions.kPaddingZero,
        children: [
          /// Available Feature
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
            child: Text("Services",
                style: context.textTheme.labelLarge?.copyWith(
                    color: appColor.brand800, fontWeight: FontWeight.w600)),
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Attendance"),
            icon: AppSvg.attendance,
            label: 'Attendance',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Attendance Report"),
            icon: AppSvg.attendance,
            label: 'Attendance Report',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Food Attendance"),
            icon: AppSvg.foodFill,
            label: 'Food Attendance',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Misspunch"),
            icon: AppSvg.missPunch,
            label: 'Misspunch',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("OD | Permission"),
            icon: AppSvg.calendar,
            label: 'OD | Permission',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Payroll"),
            icon: AppSvg.payroll,
            label: 'Payroll',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Expenses"),
            icon: AppSvg.asset,
            label: 'Expenses',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Appreciation"),
            width: 20.w,
            icon: AppSvg.appreciation,
            label: 'Appreciation',
          ),
          appDrawerMenuButton(
            onPressed: () => goTo("Renewal Tracking"),
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
            onPressed: () => goTo("Change Password"),
            icon: AppSvg.changePassword,
            width: 22.w,
            label: 'Change Password',
          ),

          Dimensions.kVerticalSpaceSmall,

          /// Additional Feature
          BlocBuilder<AppVersionCheckerCubit, AppVersionCheckerState>(
            builder: (context, state) {
              if (state is AppVersionCheckerLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6)
                          .w,
                      child: Text(
                        "Share",
                        style: context.textTheme.labelLarge?.copyWith(
                            color: appColor.brand800,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    appDrawerMenuButton(
                      onPressed: () => Share.share(state.appVersion.url!),
                      icon: AppSvg.share,
                      width: 12.w,
                      color: appColor.brand600,
                      label: 'Invite Teams',
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void goTo(label) {
    switch (label) {
      case "Attendance":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.attendance);
        break;

      case "Attendance Report":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.attendanceReport);
        break;

      case "Food Attendance":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.foodAttendance);
        break;

      case "Misspunch":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.misspunch);
        break;

      case "OD | Permission":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.oDPermissionScreen);
        break;

      case "Payroll":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.payrollScreen);
        break;

      case "Expenses":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.expensesScreen);
        break;

      case "Appreciation":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.appreciationScreen);
        break;

      case "Renewal Tracking":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.renewalTrackingScreen);
        break;

      case "Change Password":
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRouterPath.changePasswordScreen);
        break;

      default:
        Navigator.pushNamed(context, AppRouterPath.noRoute);
        break;
    }
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
      Color? color,
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
              colorFilter:
                  ColorFilter.mode(color ?? appColor.gray700, BlendMode.srcIn),
            ),
            Dimensions.kHorizontalSpaceMedium,
            Text(
              label,
              style: context.textTheme.labelLarge?.copyWith(
                  color: color ?? appColor.gray700,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
