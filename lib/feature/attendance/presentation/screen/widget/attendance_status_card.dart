import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifive_hrms/core/core.dart';

import '../../../../../config/config.dart';
import '../../../../dashboard/dashboard.dart';

class AttendanceStatusCard extends StatelessWidget {
  const AttendanceStatusCard({super.key});

  String getTime(String? dateTime) {
    if (dateTime != null) {
      return dateTime.split(' ').last;
    }
    return '00:00:00';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceStatusCubit, AttendanceStatusState>(
      builder: (context, state) {
        if (state is AttendanceStatusLoading) {
          return const AttendanceStatusShimmerLoading();
        }
        if (state is AttendanceStatusLoaded) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(
                    color: getBGColor(getTime(
                        state.attendanceResponse.workDetails!.sTimestamp)),
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "CheckIn",
                        style: context.textTheme.labelLarge?.copyWith(
                            color: getTextColor(getTime(state
                                .attendanceResponse.workDetails!.sTimestamp))),
                      ),
                      Text(
                        getTime(
                            state.attendanceResponse.workDetails!.sTimestamp),
                        style: context.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: getTextColor(getTime(state
                                .attendanceResponse.workDetails!.sTimestamp))),
                      ),
                    ],
                  ),
                ),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Expanded(
                child: Container(
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(
                    color: getBGColor(getTime(
                        state.attendanceResponse.workDetails!.eTimestamp)),
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "CheckOut",
                        style: context.textTheme.labelLarge?.copyWith(
                            color: getTextColor(getTime(state
                                .attendanceResponse.workDetails!.eTimestamp))),
                      ),
                      Text(
                        getTime(
                            state.attendanceResponse.workDetails!.eTimestamp),
                        style: context.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: getTextColor(getTime(state
                                .attendanceResponse.workDetails!.eTimestamp))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const AttendanceStatusShimmerLoading();
      },
    );
  }

  Color getBGColor(label) {
    if (label == "00:00:00") {
      return appColor.gray100;
    } else {
      return appColor.success500;
    }
  }

  Color getTextColor(label) {
    if (label == "00:00:00") {
      return appColor.gray900;
    } else {
      return appColor.white;
    }
  }
}

class AttendanceStatusShimmerLoading extends StatelessWidget {
  const AttendanceStatusShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: Dimensions.kPaddingAllMedium,
            decoration: BoxDecoration(
              color: appColor.gray300,
              borderRadius: Dimensions.kBorderRadiusAllSmaller,
            ),
            child: ShimmerWidget(
              child: Column(
                children: [
                  Text("CheckIn", style: context.textTheme.labelLarge),
                  Container(
                    height: 32.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: appColor.gray700.withOpacity(.4),
                      borderRadius: Dimensions.kBorderRadiusAllSmallest,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Dimensions.kHorizontalSpaceSmaller,
        Expanded(
          child: Container(
            padding: Dimensions.kPaddingAllMedium,
            decoration: BoxDecoration(
              color: appColor.gray300,
              borderRadius: Dimensions.kBorderRadiusAllSmaller,
            ),
            child: ShimmerWidget(
              child: Column(
                children: [
                  Text(
                    "CheckOut",
                    style: context.textTheme.labelLarge,
                  ),
                  Container(
                    height: 32.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: appColor.gray700.withOpacity(.4),
                      borderRadius: Dimensions.kBorderRadiusAllSmallest,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
