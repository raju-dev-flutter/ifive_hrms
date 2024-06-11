import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../food.dart';

class FoodAttendanceReportScreen extends StatefulWidget {
  const FoodAttendanceReportScreen({super.key});

  @override
  State<FoodAttendanceReportScreen> createState() =>
      _FoodAttendanceReportScreenState();
}

class _FoodAttendanceReportScreenState
    extends State<FoodAttendanceReportScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack(DateFormat('dd-MM-yyyy').format(selectedDate));
  }

  Future<void> initialCallBack(String date) async {
    BlocProvider.of<FoodAttendanceReportCubit>(context)
        .getFoodAttendanceReportList(date);
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
          title: "Food Attendance Report",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return Column(
      children: [
        foodAttendanceSearchCardUI(),
        foodAttendanceReportTotalCountCardUI(),
        Dimensions.kVerticalSpaceSmallest,
        Expanded(
          child:
              BlocBuilder<FoodAttendanceReportCubit, FoodAttendanceReportState>(
            builder: (context, state) {
              if (state is FoodAttendanceReportLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is FoodAttendanceReportLoaded) {
                final attendanceList = state.attendanceList.foodCountList;
                return RefreshIndicator(
                  onRefresh: () async {
                    initialCallBack(
                        DateFormat('dd-MM-yyyy').format(selectedDate));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16, top: 6)
                        .w,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: attendanceList!.length,
                    itemBuilder: (_, i) {
                      return foodAttendanceReportCardUI(attendanceList[i]);
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

  Widget foodAttendanceSearchCardUI() {
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
                initialCallBack(DateFormat('dd-MM-yyyy').format(date));
              },
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: Dimensions.kBorderRadiusAllSmallest,
                  border: Border.all(
                    width: 1,
                    color: appColor.gray300.withOpacity(.8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12).w,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month, color: appColor.gray600),
                      Dimensions.kHorizontalSpaceSmall,
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            DateFormat('dd-MM-yyyy').format(selectedDate),
                            style: context.textTheme.labelLarge,
                          ),
                        ),
                      ),
                      Dimensions.kHorizontalSpaceMedium,
                    ],
                  ),
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
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                color: appColor.blue600,
              ),
              child: Text(
                'SEARCH',
                style: context.textTheme.labelLarge
                    ?.copyWith(color: appColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget foodAttendanceReportTotalCountCardUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12).w,
        decoration: BoxDecoration(
          borderRadius: Dimensions.kBorderRadiusAllSmallest,
          color: appColor.success600,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FoodAttendanceReportCubit,
                    FoodAttendanceReportState>(
                  builder: (context, state) {
                    if (state is FoodAttendanceReportLoading) {
                      return foodAttendanceOrderCount("00");
                    }
                    if (state is FoodAttendanceReportLoaded) {
                      final attendanceList = state.attendanceList.foodCountList;
                      return foodAttendanceOrderCount(
                          attendanceList![0].count.toString());
                    }
                    return Container();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget foodAttendanceOrderCount(String count) {
    return RichText(
      text: TextSpan(
        text: 'Total Food Order : ',
        style: context.textTheme.labelLarge?.copyWith(color: appColor.white),
        children: [
          TextSpan(
            text: count,
            style: context.textTheme.bodyMedium?.copyWith(
              color: appColor.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget foodAttendanceReportCardUI(FoodCountList food) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2).w,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).w,
          color: food.finalStatus == "No Need"
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
            foodAttendanceReportTextCardUI(label: food.firstName ?? ''),
            foodAttendanceReportTextCardUI(label: food.finalStatus ?? ''),
            foodAttendanceReportTextCardUI(label: food.createdAt ?? ''),
          ],
        ),
      ),
    );
  }

  Widget foodAttendanceReportTextCardUI({required String label}) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: context.textTheme.labelSmall?.copyWith(color: appColor.white),
      ),
    );
  }
}
