import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class ProjectTaskDetailCardWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final TaskData task;

  const ProjectTaskDetailCardWidget(
      {super.key, required this.onPressed, required this.task});

  Color getColor(String label) {
    switch (label) {
      case "INITIATED":
        return appColor.warning600;
      case "APPROVED" || "APPROVE":
        return appColor.success600;
      case "PENDING":
        return appColor.purple600;
      case "NOT INITIATED" || "REJECTED" || "REJECT" || "CANCELLED":
        return appColor.error600;
    }
    return appColor.success600;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Dimensions.kBorderRadiusAllSmaller,
      child: Container(
        padding: const EdgeInsets.all(12).w,
        decoration: boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: Dimensions.kPaddingAllSmaller,
                  child: SvgPicture.asset(
                    AppSvg.accountOutline,
                    width: 14,
                    colorFilter:
                        ColorFilter.mode(appColor.brand600, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    task.firstName ?? ".",
                    style: context.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                if (task.status!.toUpperCase() != "COMPLETED") ...[
                  SizedBox(width: 4.w),
                  badge(
                    context,
                    color: getColor((task.status ?? "").toUpperCase()),
                    label: (task.status ?? "").toUpperCase(),
                  ),
                ],
              ],
            ),
            Row(
              children: [
                Container(
                  padding: Dimensions.kPaddingAllSmaller,
                  child: SvgPicture.asset(
                    AppSvg.task,
                    width: 18,
                    colorFilter:
                        ColorFilter.mode(appColor.brand600, BlendMode.srcIn),
                  ),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.task ?? "",
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: Dimensions.kPaddingAllSmaller,
                  child: SvgPicture.asset(
                    AppSvg.calendar,
                    width: 18,
                    colorFilter:
                        ColorFilter.mode(appColor.brand600, BlendMode.srcIn),
                  ),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "",
                          style: context.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(text: task.startDate ?? ""),
                            TextSpan(
                              text: " to ",
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: appColor.brand600),
                            ),
                            TextSpan(text: task.endDate ?? ""),
                          ],
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
  }

  Widget badge(BuildContext context,
      {Color? color, String? label, Widget? child}) {
    return Container(
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        color: (color ?? appColor.blue100).withOpacity(.2),
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: child ??
          Text(
            label ?? "",
            style: context.textTheme.labelSmall?.copyWith(
                color: color ?? appColor.blue100, fontWeight: FontWeight.bold),
          ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.white,
      borderRadius: Dimensions.kBorderRadiusAllSmaller,
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

class TaskCardShimmerWidget extends StatelessWidget {
  const TaskCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Container(
        padding: const EdgeInsets.all(14).w,
        decoration: boxDecoration(),
        child: ShimmerWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: Dimensions.kPaddingAllSmall,
                    child: SvgPicture.asset(
                      AppSvg.accountOutline,
                      width: 14,
                      colorFilter:
                          ColorFilter.mode(appColor.brand600, BlendMode.srcIn),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      width: context.deviceSize.width,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2).w,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  ShimmerWidget(
                    child: badge(
                      context,
                      color: appColor.warning500,
                      label: ("Status").toUpperCase(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: Dimensions.kPaddingAllSmall,
                    child: SvgPicture.asset(
                      AppSvg.task,
                      width: 18,
                      colorFilter:
                          ColorFilter.mode(appColor.brand600, BlendMode.srcIn),
                    ),
                  ),
                  Dimensions.kHorizontalSpaceSmall,
                  Expanded(
                    child: Container(
                      width: context.deviceSize.width,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2).w,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: Dimensions.kPaddingAllSmall,
                    child: SvgPicture.asset(
                      AppSvg.calendar,
                      width: 18,
                      colorFilter:
                          ColorFilter.mode(appColor.brand600, BlendMode.srcIn),
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
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2).w,
                          ),
                        ),
                        Dimensions.kVerticalSpaceSmallest,
                        Container(
                          width: 150.w,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
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
      ),
    );
  }

  Widget badge(BuildContext context,
      {Color? color, String? label, Widget? child}) {
    return Container(
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        color: (color ?? appColor.blue100).withOpacity(.2),
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: child ??
          Text(
            label ?? "",
            style: context.textTheme.labelSmall?.copyWith(
                color: color ?? appColor.blue100, fontWeight: FontWeight.bold),
          ),
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
