import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../dashboard/dashboard.dart';
import '../../attendance.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final attendanceStream = sl<AttendanceStream>();
  String currentTime = '';

  @override
  void initState() {
    currentTime = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();

    attendanceStream.fetchInitialCallBack(context);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    setState(() => currentTime = _formatDateTime(now));
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
        .getAttendanceStatus(SharedPrefs().getToken());
  }

  String getCurrentDate() {
    final splitDate = DateFormat('yyyy-MM-dd hh:mm')
        .format(DateTime.now())
        .split(' ')[0]
        .split('-');

    int year = int.parse(splitDate[0]);
    int date = int.parse(splitDate[1]);
    int month = int.parse(splitDate[2]);
    DateTime now = DateTime(year, date, month);

    return '${Convert.day(now)}, ${splitDate[2]}  ${Convert.month(now)}  $year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.white,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Attendance",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return StreamBuilder<bool>(
      stream: attendanceStream.gprsLocationScanning,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  width: context.deviceSize.width,
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(color: appColor.white),
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmall,
                      Text(
                        currentTime,
                        style: context.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: appColor.brand600),
                      ),
                      Text(
                        getCurrentDate(),
                        style: context.textTheme.labelMedium
                            ?.copyWith(color: appColor.brand600),
                      ),
                      Dimensions.kVerticalSpaceLarge,
                      const AttendanceStatusCard(),
                      Dimensions.kVerticalSpaceLarge,
                      Dimensions.kVerticalSpaceLarge,
                      Dimensions.kVerticalSpaceLarge,
                    ],
                  ),
                ),
                // Dimensions.kSpacer,
                Expanded(
                  child: Container(
                    width: context.deviceSize.width,
                    padding: Dimensions.kPaddingAllMedium,
                    decoration: BoxDecoration(
                        color: appColor.white,
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(16).w,
                          topLeft: const Radius.circular(16).w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: appColor.gray100,
                            offset: const Offset(0, -3),
                            blurRadius: 6,
                            spreadRadius: 3,
                          ),
                        ]),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Dimensions.kVerticalSpaceLarge,
                          AttendanceActionCard(
                              attendanceStream: attendanceStream),
                          Dimensions.kVerticalSpaceLarge,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (snapshot.data == true)
              Container(
                height: context.deviceSize.height,
                width: context.deviceSize.width,
                alignment: Alignment.center,
                color: appColor.white.withOpacity(.6),
                child: Lottie.asset(AppLottie.locationScanning, width: 200.w),
              ),
          ],
        );
      },
    );
  }
}
