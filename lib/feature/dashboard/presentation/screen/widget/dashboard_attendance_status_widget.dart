part of 'widget.dart';

class DashboardAttendanceStatusWidget extends StatelessWidget {
  const DashboardAttendanceStatusWidget({super.key});

  String getTime(String? dateTime) {
    if (dateTime != null) {
      return dateTime.split(' ').last;
    }
    return '00:00:00';
  }

  @override
  Widget build(BuildContext context) {
    final token = SharedPrefs().getToken();
    BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
        .getAttendanceStatus(token);
    return BlocConsumer<AttendanceStatusCubit, AttendanceStatusState>(
      listener: (context, state) {
        if (state is AttendanceStatusFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
          }
        }
      },
      builder: (context, state) {
        if (state is AttendanceStatusLoading) {
          return const DashboardAttendanceStatusLoading();
        }
        if (state is AttendanceStatusLoaded) {
          return Container(
            padding: Dimensions.kPaddingAllMedium,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouterPath.attendance),
                    child: Container(
                      padding: Dimensions.kPaddingAllMedium,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).w,
                        color: appColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: appColor.gray200.withOpacity(.2),
                            offset: const Offset(0, 3),
                            spreadRadius: 3,
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                padding: const EdgeInsets.all(6).w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: appColor.brand100,
                                  borderRadius:
                                      Dimensions.kBorderRadiusAllMedium,
                                ),
                                child: SvgPicture.asset(
                                  AppSvg.crossArrowDown,
                                  colorFilter: ColorFilter.mode(
                                    appColor.brand950,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Check In',
                                style: context.textTheme.titleLarge?.copyWith(
                                    color: appColor.brand950,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            getTime(state
                                .attendanceResponse.workDetails!.sTimestamp),
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: appColor.brand950,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Dimensions.kHorizontalSpaceSmaller,
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouterPath.attendance),
                    child: Container(
                      padding: Dimensions.kPaddingAllMedium,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).w,
                        color: appColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: appColor.gray200.withOpacity(.2),
                            offset: const Offset(0, 3),
                            spreadRadius: 3,
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                padding: const EdgeInsets.all(6).w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: appColor.brand100,
                                  borderRadius:
                                      Dimensions.kBorderRadiusAllMedium,
                                ),
                                child: SvgPicture.asset(
                                  AppSvg.crossArrowUp,
                                  colorFilter: ColorFilter.mode(
                                    appColor.brand950,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Check Out',
                                style: context.textTheme.titleLarge?.copyWith(
                                    color: appColor.brand950,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            getTime(state
                                .attendanceResponse.workDetails!.eTimestamp),
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: appColor.brand950,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class DashboardAttendanceStatusLoading extends StatelessWidget {
  const DashboardAttendanceStatusLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: appColor.gray50,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                boxShadow: [
                  BoxShadow(
                    color: appColor.gray600.withOpacity(.1),
                    blurRadius: 12,
                    spreadRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ShimmerWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllMedium,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: appColor.gray600.withOpacity(.4),
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
                color: appColor.gray50,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                boxShadow: [
                  BoxShadow(
                    color: appColor.gray600.withOpacity(.1),
                    blurRadius: 12,
                    spreadRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ShimmerWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllMedium,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                            color: appColor.gray600.withOpacity(.4),
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: appColor.gray600.withOpacity(.4),
                        borderRadius: Dimensions.kBorderRadiusAllSmallest,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
