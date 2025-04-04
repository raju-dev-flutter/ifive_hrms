import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../feature.dart';

enum UpgradeMethod { all, hot, increment }

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'UNKNOWN',
    packageName: 'UNKNOWN',
    version: 'UNKNOWN',
    buildNumber: 'UNKNOWN',
    buildSignature: 'UNKNOWN',
    installerStore: 'UNKNOWN',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
    BlocProvider.of<AppVersionCheckerCubit>(context, listen: false)
        .appVersion();
  }

  @override
  Widget build(BuildContext context) {
    final navigationCubit = BlocProvider.of<NavigationCubit>(context);
    final jsonMenu = SharedPrefs.instance.getString(AppKeys.menu) ?? '';
    List<String> menu = jsonDecode(jsonMenu).cast<String>();
    return BlocListener<AppVersionCheckerCubit, AppVersionCheckerState>(
      listener: (context, state) {
        if (state is AppVersionCheckerLoaded) {
          Logger().i(state.appVersion.version);
          final Version currentVersion =
              Version.parse(state.appVersion.version ?? '');
          final Version latestVersion = Version.parse(_packageInfo.version);

          final comparison = currentVersion.compareTo(latestVersion);

          if (comparison < 0) {
            showUpdateAlert(state.appVersion, 'old');
          } else if (comparison > 0) {
            showUpdateAlert(state.appVersion, 'new');
          }
        }
      },
      child: Scaffold(
        backgroundColor: appColor.gray50,
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        body: WillPopScope(
          onWillPop: () async {
            bool shouldCloseApp =
                await AppAlerts.displayExitAppAlert(context: context);
            return shouldCloseApp;
          },
          child: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
            if (state.navbarItem == NavbarItem.dashboard) {
              return DashboardScreen(scaffold: _scaffoldKey);
            } else if (state.navbarItem == NavbarItem.home) {
              return HomeScreen(scaffold: _scaffoldKey);
            } else if (state.navbarItem == NavbarItem.calendar) {
              return CalendarScreen(scaffold: _scaffoldKey);
            } else if (state.navbarItem == NavbarItem.task) {
              return TaskScreen(scaffold: _scaffoldKey);
            } else if (state.navbarItem == NavbarItem.database) {
              return DatabaseScreen(scaffold: _scaffoldKey);
            } else if (state.navbarItem == NavbarItem.account) {
              return AccountScreen(scaffold: _scaffoldKey);
            }
            return Container();
          }),
        ),
        floatingActionButton: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
          if (state.navbarItem == NavbarItem.database) {
            return FloatingActionButton(
              onPressed: () => Navigator.pushNamed(
                  context, AppRouterPath.databaseCameraScreen),
              child: const Icon(Icons.camera),
            );
          }
          return FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRouterPath.chatContactScreen),
            child: const Icon(Icons.chat_rounded),
          );
        }),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return Container(
              height: 84.h,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20).h,
              decoration: BoxDecoration(
                color: appColor.white,
                border: Border.all(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: appColor.gray300.withOpacity(.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: appColor.gray50.withOpacity(.1),
                    blurRadius: 6,
                    spreadRadius: 4,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (menu.contains('dashboard'))
                    navigationGroupButton(
                      context: context,
                      onTap: () =>
                          navigationCubit.getNavBarItem(NavbarItem.dashboard),
                      label: 'Dashboard',
                      svgSrc: state.index == 0
                          ? AppSvg.dashboardFill
                          : AppSvg.dashboardOutline,
                      color: state.index == 0
                          ? appColor.brand800
                          : appColor.gray400,
                      fontWeight: FontWeight.w500,
                    ),
                  if (menu.contains('home'))
                    navigationGroupButton(
                      context: context,
                      onTap: () =>
                          navigationCubit.getNavBarItem(NavbarItem.home),
                      label: 'Home',
                      svgSrc: state.index == 1
                          ? AppSvg.homeFill
                          : AppSvg.homeOutline,
                      color: state.index == 1
                          ? appColor.brand800
                          : appColor.gray400,
                      fontWeight: FontWeight.w500,
                    ),
                  if (menu.contains('calender'))
                    navigationGroupButton(
                      context: context,
                      onTap: () =>
                          navigationCubit.getNavBarItem(NavbarItem.calendar),
                      label: 'Calender',
                      svgSrc:
                          state.index == 2 ? AppSvg.calendar : AppSvg.calendar,
                      color: state.index == 2
                          ? appColor.brand800
                          : appColor.gray400,
                      fontWeight: FontWeight.w500,
                    ),
                  if (menu.contains('task'))
                    navigationGroupButton(
                      context: context,
                      onTap: () =>
                          navigationCubit.getNavBarItem(NavbarItem.task),
                      label: 'Task',
                      svgSrc: state.index == 3
                          ? AppSvg.taskFill
                          : AppSvg.taskOutline,
                      color: state.index == 3
                          ? appColor.brand800
                          : appColor.gray400,
                      fontWeight: FontWeight.w500,
                    ),
                  if (menu.contains('sfa'))
                    navigationGroupButton(
                      context: context,
                      onTap: () =>
                          navigationCubit.getNavBarItem(NavbarItem.database),
                      label: 'Sfa',
                      svgSrc: state.index == 4
                          ? AppSvg.taskFill
                          : AppSvg.taskOutline,
                      color: state.index == 4
                          ? appColor.brand800
                          : appColor.gray400,
                      fontWeight: FontWeight.w500,
                    ),
                  if (menu.contains('account'))
                    navigationGroupButton(
                      context: context,
                      onTap: () =>
                          navigationCubit.getNavBarItem(NavbarItem.account),
                      label: 'Account',
                      svgSrc: state.index == 5
                          ? AppSvg.accountFill
                          : AppSvg.accountOutline,
                      color: state.index == 5
                          ? appColor.brand800
                          : appColor.gray400,
                      fontWeight: FontWeight.w500,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  navigationGroupButton({
    required BuildContext context,
    required Function() onTap,
    required String label,
    required String svgSrc,
    required Color color,
    required FontWeight fontWeight,
  }) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgSrc,
            width: svgSrc == AppSvg.dashboardFill ||
                    svgSrc == AppSvg.dashboardOutline
                ? 22.w
                : 18.w,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          svgSrc == AppSvg.dashboardFill || svgSrc == AppSvg.dashboardOutline
              ? const SizedBox(height: 0)
              : SizedBox(height: 4.h),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: color, fontWeight: fontWeight),
          )
        ],
      ),
    ));
  }

  void showUpdateAlert(AppVersionModel appVersion, String label) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppUpdater(
            appVersion: appVersion, packageInfo: _packageInfo, label: label);
      },
    );
  }
}

class AppUpdater extends StatefulWidget {
  final String label;
  final AppVersionModel appVersion;
  final PackageInfo packageInfo;

  const AppUpdater(
      {super.key,
      required this.appVersion,
      required this.packageInfo,
      required this.label});

  @override
  State<AppUpdater> createState() => _AppUpdaterState();
}

class _AppUpdaterState extends State<AppUpdater> {
  double? progress = 0;
  int? status = 0;

  UpgradeMethod? upgradeMethod;

  @override
  void initState() {
    super.initState();

    // RUpgrade.setDebug(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appColor.white,
      alignment: Alignment.center,
      title: Text(
        "${AppKeys.companyName}?",
        style: context.textTheme.bodyMedium
            ?.copyWith(fontWeight: FontWeight.w500, color: appColor.gray700),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dimensions.kVerticalSpaceSmaller,
          RichText(
            text: TextSpan(
              style: context.textTheme.labelLarge,
              children: const [
                TextSpan(
                    text:
                        '${AppKeys.companyName} recommends that you update to the latest version. You can keep using this app while downloading the update.'),
              ],
            ),
          ),
          Dimensions.kVerticalSpaceSmall,
          RichText(
            text: TextSpan(
              style: context.textTheme.labelLarge,
              children: [
                const TextSpan(text: 'Current you have :'),
                TextSpan(
                  text: ' V-${widget.packageInfo.version} ',
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Dimensions.kVerticalSpaceSmall,
          RichText(
            text: TextSpan(
              style: context.textTheme.labelLarge,
              children: [
                const TextSpan(text: 'Now available version :'),
                TextSpan(
                  text: ' V-${widget.appVersion.version} ',
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Dimensions.kVerticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: packageInstaller,
                child: Text(
                  "UPDATE NOW",
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500, color: appColor.success600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void packageInstaller() async {
    try {
      Navigator.pop(context);
      String url = "";
      if (Platform.isAndroid) {
        String packageName = widget.packageInfo.packageName;
        url = 'https://play.google.com/store/apps/details?id=$packageName';
      } else if (Platform.isIOS) {
        String bundleId = widget.packageInfo.packageName;
        url = 'https://apps.apple.com/app/id$bundleId';
      }
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } on PlatformException {
      Logger().e('Error at Platform. Failed to install apk file.');
    }
  }
}
