import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config.dart';
import '../../feature/feature.dart';
import '../core.dart';

enum UpgradeMethod { all, hot, increment }

class CustomAppUpdater extends StatelessWidget {
  final String label;
  final AppVersionModel appVersion;
  final PackageInfo packageInfo;

  const CustomAppUpdater(
      {super.key,
      required this.appVersion,
      required this.packageInfo,
      required this.label});

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
                      '${AppKeys.companyName} recommends that you update to the latest version. '
                      'You can keep using this app while downloading the update.',
                ),
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
                  text: ' V-${packageInfo.version} ',
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
                  text: ' V-${appVersion.version} ',
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
                onPressed: _launchPlayStore,
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

  Future<void> _launchPlayStore() async {
    String url = "";
    if (Platform.isAndroid) {
      url =
          'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';
    } else if (Platform.isIOS) {
      String bundleId = "000000000";
      url = 'https://apps.apple.com/app/id$bundleId';
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
