import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../attendance.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack(DateFormat('yyyy-MM-dd').format(selectedDate));
  }

  Future<void> initialCallBack(String date) async {
    final id = SharedPrefs().getId();
    BlocProvider.of<AttendanceReportCubit>(context)
        .grtAttendanceUserList(date, id.toString());
  }

  Future<void> refresh() async {
    initialCallBack(DateFormat('yyyy-MM-dd').format(selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Over All Attendance",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return Column(
      children: [
        attendanceSearchCardUI(),
        Expanded(
          child: BlocBuilder<AttendanceReportCubit, AttendanceReportState>(
            builder: (context, state) {
              if (state is AttendanceReportLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is AttendanceReportLoaded) {
                final attendanceList = state.attendanceList.overallAttendance;
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16)
                            .w,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: attendanceList!.length,
                    itemBuilder: (_, i) {
                      return attendanceReportCardUI(attendanceList[i]);
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget attendanceSearchCardUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).w,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: selectedDate, startDate: null);
                setState(() => selectedDate = date);
                initialCallBack(DateFormat('yyyy-MM-dd').format(date));
              },
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: appColor.white,
                  borderRadius: Dimensions.kBorderRadiusAllSmallest,
                  border: Border.all(width: 1, color: const Color(0xFFF4F4F4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy').format(selectedDate),
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray900,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 12,
                      colorFilter: ColorFilter.mode(
                        appColor.gray700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Dimensions.kHorizontalSpaceSmaller,
          InkWell(
            onTap: () =>
                initialCallBack(DateFormat('dd-MM-yyyy').format(selectedDate)),
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColor.brand800,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
              ),
              child: SvgPicture.asset(
                AppSvg.search,
                width: 14,
                colorFilter: ColorFilter.mode(
                  appColor.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statusTag({required Color color, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4).w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8).w),
      child: Text(
        label,
        style: context.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.w500, color: color),
      ),
    );
  }

  Widget attendanceReportCardUI(OverallAttendance attendance) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        // onTap: () => Navigator.pushNamed(
        //         context, AppRouterPath.attendanceEmployeeDetailScreen,
        //         arguments:
        //             AttendanceEmployeeDetailScreen(attendance: attendance))
        //     .then((value) =>
        //         initialCallBack(DateFormat('dd-MM-yyyy').format(selectedDate))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).w,
            color: color(attendance.attendanceStatus).withOpacity(.1),
            boxShadow: [
              BoxShadow(
                color: color(attendance.attendanceStatus).withOpacity(.05),
                offset: const Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      attendance.employeeName ?? '',
                      style: context.textTheme.labelLarge?.copyWith(
                          color: color(attendance.attendanceStatus),
                          fontWeight: FontWeight.w500,
                          letterSpacing: .5),
                    ),
                    statusTag(
                      color: color(attendance.attendanceStatus),
                      label: attendance.attendanceStatus ?? 'Absent',
                    ),
                  ],
                ),
              ),
              Divider(height: 0, thickness: .6, color: appColor.success50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeAndHourCardUI(
                      label: 'Start Time',
                      time: attendance.sTimestamp ?? "00:00",
                      color: color(attendance.attendanceStatus),
                    ),
                    timeAndHourCardUI(
                      label: 'End Time',
                      time: attendance.eTimestamp ?? "00:00",
                      color: color(attendance.attendanceStatus),
                    ),
                    // timeAndHourCardUI(
                    //   label: 'Total Duration',
                    //   time: attendance. ?? "00:00",
                    //   color: color(attendance.active),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  color(label) {
    return label != "Present" ? appColor.error600 : appColor.success600;
  }

  Widget timeAndHourCardUI(
      {required String label, required String time, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(color: color),
          ),
          SizedBox(height: 2.w),
          Text(
            time,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
