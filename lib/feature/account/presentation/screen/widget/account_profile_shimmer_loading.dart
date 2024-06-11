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
        // Container(
        //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16).w,
        //   decoration: const BoxDecoration(color: AppColor.bgPrimary),
        //   width: context.deviceSize.width,
        //   child: ShimmerWidget(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Container(
        //           width: 100.w,
        //           height: 20.h,
        //           color: AppColor.bgSecondarySolid.withOpacity(.5),
        //         ),
        //         Dimensions.kVerticalSpaceSmallest,
        //         Container(
        //           width: 120.w,
        //           height: 16.h,
        //           color: AppColor.bgSecondarySolid.withOpacity(.5),
        //         ),
        //         SizedBox(height: 1.h),
        //         Container(
        //           width: 60.w,
        //           height: 16.h,
        //           color: AppColor.bgSecondarySolid.withOpacity(.5),
        //         ),
        //         SizedBox(height: 4.h),
        //         Divider(color: AppColor.bgBrandPrimary.withOpacity(.1)),
        //         SizedBox(height: 4.h),
        //         Container(
        //           width: 80.w,
        //           height: 16.h,
        //           color: AppColor.bgSecondarySolid.withOpacity(.5),
        //         ),
        //         SizedBox(height: 1.h),
        //         Container(
        //           width: 60.w,
        //           height: 16.h,
        //           color: AppColor.bgSecondarySolid.withOpacity(.5),
        //         ),
        //         SizedBox(height: 4.h),
        //         Divider(color: AppColor.bgSecondarySolid.withOpacity(.1)),
        //         SizedBox(height: 4.h),
        //         Container(
        //           width: 100.w,
        //           height: 16.h,
        //           color: AppColor.bgSecondarySolid.withOpacity(.5),
        //         ),
        //         SizedBox(height: 1.h),
        //         Container(
        //           width: 60.w,
        //           height: 16.h,
        //           color: AppColor.bgSecondarySolid.withOpacity(.5),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
