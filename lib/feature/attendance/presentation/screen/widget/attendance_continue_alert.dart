import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class AttendanceContinueAlert extends StatelessWidget {
  const AttendanceContinueAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: Dimensions.kPaddingAllMedium,
            width: context.deviceSize.width,
            decoration: BoxDecoration(
              color: appColor.brand600,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ).w,
            ),
            child: Text(
              "Already Work Started",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: appColor.white),
            ),
          ),
          // Dimensions.kVerticalSpaceSmall,
          Container(
            width: context.deviceSize.width,
            padding: Dimensions.kPaddingAllMedium,
            decoration: BoxDecoration(
              color: appColor.gray50,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ).w,
            ),
            child: Column(
              children: [
                Dimensions.kVerticalSpaceSmallest,
                Text(
                  "Do you want to change the start work ?",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: appColor.brand900),
                ),
                Dimensions.kVerticalSpaceLarge,
                Row(
                  children: [
                    Dimensions.kHorizontalSpaceMedium,
                    Expanded(
                      child: ActionButton(
                        height: 40,
                        onPressed: () => Navigator.pop(context, false),
                        color: appColor.error600,
                        child: Text(
                          "CANCEL",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: appColor.white),
                        ),
                      ),
                    ),
                    Dimensions.kHorizontalSpaceSmall,
                    Expanded(
                      child: ActionButton(
                        height: 40,
                        onPressed: () => Navigator.pop(context, true),
                        color: appColor.success600,
                        child: Text(
                          "YES",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: appColor.white),
                        ),
                      ),
                    ),
                    Dimensions.kHorizontalSpaceMedium,
                  ],
                ),
                Dimensions.kVerticalSpaceSmallest,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
