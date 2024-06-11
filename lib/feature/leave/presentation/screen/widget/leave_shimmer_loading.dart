import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class LeaveShimmerLoading extends StatelessWidget {
  const LeaveShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Container(
        decoration: BoxDecoration(
          color: appColor.gray50,
          borderRadius: BorderRadius.circular(8).w,
          border: Border(
              left: BorderSide(
                  width: 5, color: appColor.gray300.withOpacity(.5))),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF5F5F5).withOpacity(.2),
              blurRadius: 12,
              offset: const Offset(0, 3),
              spreadRadius: 3,
            ),
          ],
        ),
        child: ShimmerWidget(
          child: Column(
            children: [
              Container(
                width: context.deviceSize.width,
                padding: Dimensions.kPaddingAllMedium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 160.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                        Container(
                          width: 80.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmaller,
                    Row(
                      children: [
                        Container(
                          width: 100.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        SizedBox(
                          width: 10.w,
                          child: Divider(color: appColor.gray600),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Container(
                          width: 60.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmaller,
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppSvg.calendar,
                          width: 16.w,
                          colorFilter: ColorFilter.mode(
                              appColor.gray600, BlendMode.srcIn),
                        ),
                        Dimensions.kHorizontalSpaceSmaller,
                        Container(
                          width: 80.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                        SizedBox(width: 4.w),
                        Container(
                          width: 4.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Container(
                          width: 60.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        SizedBox(
                          width: 10.w,
                          child: Divider(color: appColor.gray600),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Container(
                          width: 60.w,
                          height: 16.h,
                          color: appColor.gray600.withOpacity(.5),
                        ),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmaller,
                    // Container(
                    //   // width: 150.w,
                    //   height: 16.h,
                    //   color: appColor.lightGrey.withOpacity(.5),
                    // ),
                    // Dimensions.kVerticalSpaceSmallest,
                    Container(
                      width: 150.w,
                      height: 16.h,
                      color: appColor.gray600.withOpacity(.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
