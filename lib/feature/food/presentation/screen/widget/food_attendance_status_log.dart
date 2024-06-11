import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../food.dart';

class FoodAttendanceStatusLog extends StatelessWidget {
  const FoodAttendanceStatusLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      child: Column(
        children: [
          Text(
            "Food Attendance Log",
            style: context.textTheme.labelLarge,
          ),
          Dimensions.kVerticalSpaceSmallest,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<FoodAttendanceStatusCubit, FoodAttendanceStatusState>(
                builder: (context, state) {
                  if (state is FoodAttendanceStatusLoading) {
                    return const StatusLogLoading();
                  }
                  if (state is FoodAttendanceStatusLoaded) {
                    return Text(
                      state.foodAttendanceResponse.message ?? '',
                      style: context.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: appColor.success600),
                    );
                  }
                  return const Text("");
                },
              ),
              SizedBox(
                width: 25.w,
                child: Divider(color: appColor.brand600, thickness: 2),
              ),
              BlocBuilder<FoodAttendanceReportCubit, FoodAttendanceReportState>(
                builder: (context, state) {
                  if (state is FoodAttendanceReportLoading) {
                    return const StatusLogLoading();
                  }
                  if (state is FoodAttendanceReportLoaded) {
                    final attendanceList = state.attendanceList.foodCountList;
                    return RichText(
                        text: TextSpan(
                            text: "",
                            style: context.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: appColor.success600),
                            children: [
                          TextSpan(
                            text: attendanceList!.first.count.toString(),
                            style: context.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: appColor.success600),
                          )
                        ]));
                  }
                  return Container();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class StatusLogLoading extends StatelessWidget {
  const StatusLogLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        height: 32.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: appColor.gray300.withOpacity(.4),
          borderRadius: Dimensions.kBorderRadiusAllSmallest,
        ),
      ),
    );
  }
}
