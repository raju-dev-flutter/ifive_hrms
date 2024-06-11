import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../attendance.dart';

class AttendanceLogCard extends StatelessWidget {
  const AttendanceLogCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceReportCubit, AttendanceReportState>(
      builder: (context, state) {
        if (state is AttendanceReportLoading) {
          return ListView.builder(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0)
                      .w,
              itemCount: 5,
              itemBuilder: (_, i) {
                return const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: LogCardShimmerLoading(),
                );
              });
        }
        if (state is AttendanceReportLogLoaded) {
          if (state.attendanceList.punchHistory!.isEmpty) {
            return Container();
          }
          return ListView.builder(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0)
                      .w,
              itemCount: state.attendanceList.punchHistory!.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: LogCardUI(
                    attendance: state.attendanceList.punchHistory![i],
                  ),
                );
              });
        }
        return Container();
      },
    );
  }
}

class LogCardUI extends StatelessWidget {
  final AttendanceReport attendance;

  const LogCardUI({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimensions.kPaddingAllSmall,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: appColor.gray50.withOpacity(.2),
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('dd').format(DateTime.now()),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColor.brand700,
                  ),
                ),
                Text(
                  Convert.day(DateTime.now()),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: appColor.brand700,
                  ),
                ),
              ],
            ),
          ),
          Dimensions.kHorizontalSpaceSmall,
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LogGroupText(
                    color: appColor.gray700,
                    label: 'Check In',
                    value: attendance.checkIn == null
                        ? ''
                        : attendance.checkIn!.split(' ').last,
                  ),
                  VerticalDivider(color: appColor.brand600),
                  LogGroupText(
                    color: appColor.error600,
                    label: 'Check Out',
                    value: attendance.checkOut == null
                        ? '00:00'
                        : attendance.checkOut!.split(' ').last,
                  ),
                  VerticalDivider(color: appColor.brand600),
                  LogGroupText(
                    color: appColor.brand700,
                    label: 'Total Hours',
                    value: attendance.workingHours ?? '00:00',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogGroupText extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const LogGroupText(
      {super.key, required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color ?? appColor.brand700,
          ),
        ),
        Text(
          label,
          style:
              context.textTheme.labelMedium?.copyWith(color: appColor.gray700),
        ),
      ],
    );
  }
}

class LogCardShimmerLoading extends StatelessWidget {
  const LogCardShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimensions.kPaddingAllSmall,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerWidget(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: appColor.brand900.withOpacity(.4),
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('dd').format(DateTime.now()),
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: appColor.brand900,
                    ),
                  ),
                  Text(
                    Convert.day(DateTime.now()),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: appColor.brand900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Dimensions.kHorizontalSpaceSmall,
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerWidget(
                    child: Column(
                      children: [
                        Container(
                          height: 20.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Container(
                          height: 15.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ShimmerWidget(
                      child: VerticalDivider(
                          color: appColor.gray600.withOpacity(.4))),
                  ShimmerWidget(
                    child: Column(
                      children: [
                        Container(
                          height: 20.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Container(
                          height: 15.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ShimmerWidget(
                      child: VerticalDivider(
                          color: appColor.gray600.withOpacity(.4))),
                  ShimmerWidget(
                    child: Column(
                      children: [
                        Container(
                          height: 20.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Container(
                          height: 15.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
