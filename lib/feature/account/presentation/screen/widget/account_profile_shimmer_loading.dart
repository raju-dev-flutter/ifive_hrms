import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class AccountProfileShimmerLoading extends StatelessWidget {
  const AccountProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: Dimensions.kPaddingAllMedium,
          decoration: BoxDecoration(color: appColor.gray100),
          child: ShimmerWidget(
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: appColor.gray200.withOpacity(.5),
                    borderRadius: Dimensions.kBorderRadiusAllLarger,
                  ),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 160.w,
                      height: 16.h,
                      color: appColor.gray300.withOpacity(.5),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      width: 60.w,
                      height: 16.h,
                      color: appColor.gray300.withOpacity(.5),
                    ),
                    SizedBox(height: 3.h),
                    Container(
                      width: 80.w,
                      height: 16.h,
                      color: appColor.gray300.withOpacity(.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
