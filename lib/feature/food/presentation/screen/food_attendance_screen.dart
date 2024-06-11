import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../food.dart';

class FoodAttendanceScreen extends StatefulWidget {
  const FoodAttendanceScreen({super.key});

  @override
  State<FoodAttendanceScreen> createState() => _FoodAttendanceScreenState();
}

class _FoodAttendanceScreenState extends State<FoodAttendanceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentTime = '';

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    currentTime = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<FoodAttendanceStatusCubit>(context, listen: false)
        .getFoodAttendanceStatus();
    getFoodAttendanceCallBack(DateFormat('dd-MM-yyyy').format(selectedDate));
  }

  Future<void> getFoodAttendanceCallBack(String date) async {
    BlocProvider.of<FoodAttendanceReportCubit>(context)
        .getFoodAttendanceReportList(date);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      currentTime = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  String getCurrentTime() {
    TimeOfDay time = TimeOfDay.now();
    return time.format(context);
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
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Food Attendance",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return BlocListener<FoodAttendanceBloc, FoodAttendanceState>(
      listener: (context, state) {
        if (state is UpdateFoodAttendanceSuccess) {
          Navigator.pop(context);
        }
        if (state is UpdateFoodAttendanceFailed) {
          Navigator.pop(context);
          AppAlerts.displaySnackBar(context, state.message, false);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: context.deviceSize.height,
        width: context.deviceSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: context.deviceSize.width,
                padding: Dimensions.kPaddingAllSmall,
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
                    Padding(
                      padding: Dimensions.kPaddingAllSmall,
                      child: Container(
                        width: context.deviceSize.width,
                        decoration: BoxDecoration(
                          color: appColor.white,
                          borderRadius: Dimensions.kBorderRadiusAllSmallest,
                          border: Border.all(
                            width: 1,
                            color: appColor.brand600.withOpacity(.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            const FoodAttendanceStatusLog(),
                            Divider(
                              color: appColor.brand600.withOpacity(.3),
                              height: 1,
                            ),
                            const FoodAttendanceAction(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Food Attendance Log',
                    style: context.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: initialCallBack,
                    child: Row(
                      children: [
                        Icon(Icons.refresh, color: appColor.brand600, size: 18),
                        SizedBox(width: 4.w),
                        Text(
                          'Refresh',
                          style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: appColor.brand600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 4,
              child: FoodAttendanceLog(),
            ),
          ],
        ),
      ),
    );
  }
}
