import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class DatabaseCardWidget extends StatelessWidget {
  final Function() onPressed;
  final DatabaseData database;

  const DatabaseCardWidget(
      {super.key, required this.onPressed, required this.database});

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.white,
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFF5F5F5).withOpacity(.2),
          offset: const Offset(0, 3),
          blurRadius: 12,
          spreadRadius: 3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8).w,
      child: Container(
        padding: const EdgeInsets.all(14).w,
        decoration: boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.company,
                  width: 18,
                  colorFilter: ColorFilter.mode(
                    appColor.blue600,
                    BlendMode.srcIn,
                  ),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        database.companyName ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.h),
                      RichText(
                        text: TextSpan(
                          text: "GST : ",
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: database.companyGst ?? "",
                              style: context.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // if (database.keyNumber != null && database.keyNumber != "") ...[
            //   Dimensions.kVerticalSpaceSmaller,
            //   GestureDetector(
            //     // onTap: () {
            //     //   // UrlLauncher().makePhoneCall(
            //     //   //     context: context, phoneNumber: database.phonenum ?? "");
            //     // },
            //     child: Row(
            //       children: [
            //         SvgPicture.asset(
            //           AppSvg.phone,
            //           width: 18,
            //           colorFilter: ColorFilter.mode(
            //             appColor.blue600,
            //             BlendMode.srcIn,
            //           ),
            //         ),
            //         Dimensions.kHorizontalSpaceSmall,
            //         Expanded(
            //           child: Text(
            //             database.keyNumber ?? "",
            //             maxLines: 2,
            //             overflow: TextOverflow.ellipsis,
            //             style: context.textTheme.labelLarge,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ],
            Dimensions.kVerticalSpaceSmall,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppSvg.location,
                  width: 14,
                  colorFilter: ColorFilter.mode(
                    appColor.blue600,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    database.addressAddress ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseCardShimmerWidget extends StatelessWidget {
  const DatabaseCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 8.h),
      itemBuilder: (_, i) {
        return Container(
          padding: const EdgeInsets.all(14).w,
          decoration: boxDecoration(),
          child: ShimmerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppSvg.company,
                      width: 18,
                      colorFilter: ColorFilter.mode(
                        appColor.blue600,
                        BlendMode.srcIn,
                      ),
                    ),
                    Dimensions.kHorizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: context.deviceSize.width,
                            height: 12,
                            decoration: BoxDecoration(
                              color: appColor.gray100,
                              borderRadius: BorderRadius.circular(2).w,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 200.w,
                            height: 12,
                            decoration: BoxDecoration(
                              color: appColor.gray100,
                              borderRadius: BorderRadius.circular(2).w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Dimensions.kVerticalSpaceSmall,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.attachment,
                      width: 18,
                      colorFilter: ColorFilter.mode(
                        appColor.blue600,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 9.w),
                    Expanded(
                      child: Container(
                        width: context.deviceSize.width,
                        height: 12,
                        decoration: BoxDecoration(
                          color: appColor.gray200,
                          borderRadius: BorderRadius.circular(2).w,
                        ),
                      ),
                    ),
                  ],
                ),
                Dimensions.kVerticalSpaceSmall,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppSvg.location,
                      width: 14,
                      colorFilter: ColorFilter.mode(
                        appColor.blue600,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: context.deviceSize.width,
                            height: 12,
                            decoration: BoxDecoration(
                              color: appColor.gray200,
                              borderRadius: BorderRadius.circular(2).w,
                            ),
                          ),
                          Dimensions.kVerticalSpaceSmallest,
                          Container(
                            width: 150.w,
                            height: 12,
                            decoration: BoxDecoration(
                              color: appColor.gray200,
                              borderRadius: BorderRadius.circular(2).w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.white.withOpacity(.6),
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFF5F5F5).withOpacity(.2),
          offset: const Offset(0, 3),
          blurRadius: 12,
          spreadRadius: 3,
        ),
      ],
    );
  }
}
