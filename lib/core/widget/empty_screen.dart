import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../config/config.dart';
import '../core.dart';

class EmptyScreen extends StatelessWidget {
  final VoidCallback? onPressed;
  const EmptyScreen({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AppLottie.empty, width: 250.w),
            Text(
              "NO RECORDS...!",
              style: context.textTheme.bodySmall,
            ),
            if (onPressed != null) ...[
              Dimensions.kVerticalSpaceSmall,
              InkWell(
                onTap: onPressed,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
                  decoration: BoxDecoration(
                    borderRadius: Dimensions.kBorderRadiusAllSmallest,
                    border: Border.all(width: 1, color: appColor.brand600),
                  ),
                  child: Text(
                    "RELOAD",
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: appColor.brand600),
                  ),
                ),
              ),
              Dimensions.kVerticalSpaceLargest,
            ]
          ],
        ),
      ),
    );
  }
}
