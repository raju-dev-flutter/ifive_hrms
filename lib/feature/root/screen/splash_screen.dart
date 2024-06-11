import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.white,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: appColor.white),
        child: Column(
          children: [
            Dimensions.kVerticalSpaceLargest,
            Dimensions.kSpacer,
            Image(
              image: const AssetImage(AppIcon.ifiveLogo),
              width: 200.w,
            ),
            Dimensions.kVerticalSpaceMedium,
            Dimensions.kSpacer,
            Image(
              image: const AssetImage(AppIcon.ifiveLogo),
              width: 50.w,
            ),
            Dimensions.kVerticalSpaceSmallest,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by: ',
                  style: context.textTheme.labelSmall
                      ?.copyWith(color: appColor.gray700.withOpacity(.8)),
                ),
                SizedBox(width: 4.w),
                Text(
                  'iFive Technology Pvt Ltd.',
                  style: context.textTheme.labelSmall,
                ),
              ],
            ),
            Dimensions.kVerticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}
