import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifive_hrms/core/core.dart';

import '../../../../../config/config.dart';
import '../../../../feature.dart';

class FoodAttendanceLog extends StatelessWidget {
  const FoodAttendanceLog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodAttendanceReportCubit, FoodAttendanceReportState>(
      builder: (context, state) {
        if (state is FoodAttendanceReportLoading) {
          return ListView.builder(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 6)
                    .w,
            itemCount: 10,
            itemBuilder: (_, i) {
              return const FoodAttendanceLogLoading();
            },
          );
        }
        if (state is FoodAttendanceReportLoaded) {
          final attendanceList = state.attendanceList.foodCountList;
          return ListView.builder(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0)
                    .w,
            itemCount: attendanceList!.length,
            itemBuilder: (_, i) {
              return ReportCardUI(attendance: attendanceList[i]);
            },
          );
        }
        return Container();
      },
    );
  }
}

class ReportCardUI extends StatelessWidget {
  final FoodCountList attendance;
  const ReportCardUI({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2).w,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).w,
          color: attendance.finalStatus == "No Need"
              ? appColor.error600.withOpacity(.9)
              : appColor.success600,
          border: Border.all(
            width: 1,
            color: appColor.white.withOpacity(.8),
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Row(
          children: [
            ReportTextCardUI(label: attendance.firstName ?? ''),
            ReportTextCardUI(label: attendance.finalStatus ?? ''),
            ReportTextCardUI(label: attendance.createdAt ?? ''),
          ],
        ),
      ),
    );
  }
}

class ReportTextCardUI extends StatelessWidget {
  final String label;
  const ReportTextCardUI({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: context.textTheme.labelSmall?.copyWith(color: appColor.white),
      ),
    );
  }
}

class FoodAttendanceLogLoading extends StatelessWidget {
  const FoodAttendanceLogLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8).w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).w,
          color: appColor.white,
        ),
        child: ShimmerWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < 3; i++)
                Container(
                  height: 22.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: appColor.gray300.withOpacity(.4),
                    borderRadius: Dimensions.kBorderRadiusAllSmallest,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
