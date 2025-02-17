import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../tour_plan.dart';

class TourPlanApprovalFormScreen extends StatefulWidget {
  const TourPlanApprovalFormScreen({super.key});

  @override
  State<TourPlanApprovalFormScreen> createState() =>
      _TourPlanApprovalFormScreenState();
}

class _TourPlanApprovalFormScreenState
    extends State<TourPlanApprovalFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController searchController = TextEditingController();

  final tourPlanApproval = sl<TourPlanApprovalStream>();

  @override
  void initState() {
    super.initState();
    tourPlanApproval.fetchInitialCallBack();
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
          title: "Tour Plan Approval",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return Column(
      children: [
        Dimensions.kVerticalSpaceMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: StreamBuilder<String>(
            stream: tourPlanApproval.selectedMonth,
            builder: (context, snapshot) {
              final month = snapshot.hasData && snapshot.data!.isNotEmpty
                  ? snapshot.data
                  : "";
              return CustomDateTimeTextFormField(
                label: "",
                hint: "SELECT MONTH",
                controller: TextEditingController(text: month),
                required: false,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomMonthYearPicker(
                        initialDate:
                            tourPlanApproval.selectedDateTime.valueOrNull ??
                                DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 100),
                        onDateSelected: (dt) {
                          tourPlanApproval.selectDateTime(dt);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        Dimensions.kVerticalSpaceSmall,
        Expanded(
          child: _TourPlanRequestListWidget(tourPlanApproval: tourPlanApproval),
        ),
        Dimensions.kVerticalSpaceLargest,
      ],
    );
  }
}

class _TourPlanRequestListWidget extends StatelessWidget {
  final TourPlanApprovalStream tourPlanApproval;

  const _TourPlanRequestListWidget({required this.tourPlanApproval});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
        boxShadow: [
          BoxShadow(
            color: appColor.gray400.withOpacity(.1),
            blurRadius: 16,
            spreadRadius: 3,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12).w,
            decoration: BoxDecoration(
              color: appColor.gray900,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(8).w,
                topRight: const Radius.circular(8).w,
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: _TourPlanTextWidget(text: "Date"),
                ),
                SizedBox(width: 4.w),
                const Expanded(
                  flex: 2,
                  child: _TourPlanTextWidget(text: "Day"),
                ),
                SizedBox(width: 4.w),
                const Expanded(
                  flex: 3,
                  child: _TourPlanTextWidget(text: "Tour Type"),
                ),
                SizedBox(width: 4.w),
                const Expanded(
                  flex: 3,
                  child: _TourPlanTextWidget(text: "Beat"),
                ),
                SizedBox(width: 4.w),
                const Expanded(
                  flex: 3,
                  child: _TourPlanTextWidget(text: "Status"),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<TourPlanModel>>(
              stream: tourPlanApproval.tourPlanLinesList,
              builder: (context, snapshot) {
                final data = snapshot.hasData && snapshot.data!.isNotEmpty
                    ? snapshot.data
                    : [];
                return ListView.separated(
                  itemBuilder: (_, i) {
                    return _TourPlanLinesWidget(
                      tp: data[i],
                      tourPlanStatusOnPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomContentPicker(
                              label: 'SELECT TOUR PLAN STATUS',
                              isSearch: false,
                              height: 80.h,
                              initialData:
                                  data[i].tourTypeListInit ?? CommonList(),
                              streamList: tourPlanApproval
                                      .tourPlanStatusList.valueOrNull ??
                                  [],
                              onChanged: (CommonList data) {
                                tourPlanApproval.tourPlanStatus(data, i);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, i) {
                    return Dimensions.kDivider;
                  },
                  itemCount: data!.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TourPlanLinesWidget extends StatelessWidget {
  final VoidCallback tourPlanStatusOnPressed;
  final TourPlanModel tp;

  const _TourPlanLinesWidget(
      {required this.tourPlanStatusOnPressed, required this.tp});

  Color getBgColor(String label) {
    switch (label) {
      case "APPROVED":
        return appColor.success200;
      case "REJECTED":
        return appColor.error200;
      default:
        return appColor.white;
    }
  }

  Color getTextColor(String label) {
    switch (label) {
      case "APPROVED":
        return appColor.success800;
      case "REJECTED":
        return appColor.error800;
      default:
        return appColor.gray900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = getBgColor(tp.tourPlanStatus!.name ?? "");
    final textColor = getTextColor(tp.tourPlanStatus!.name ?? "");
    return ColoredBox(
      color: bgColor,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _TourPlanTextWidget(text: tp.date ?? "", color: textColor),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 2,
            child: _TourPlanTextWidget(text: tp.day ?? "", color: textColor),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 3,
            child: _TourPlanTextWidget(
                text: tp.tourTypeInit ?? "", color: textColor),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 3,
            child:
                _TourPlanTextWidget(text: tp.beatInit ?? "", color: textColor),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: tourPlanStatusOnPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12).w,
                child: _TourPlanTextWidget(
                  text: tp.tourPlanStatus?.name ?? "--SELECT--",
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TourPlanTextWidget extends StatelessWidget {
  final String text;
  final Color? color;

  const _TourPlanTextWidget({required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: context.textTheme.labelMedium?.copyWith(
        color:
            text == "--SELECT--" ? appColor.gray400 : color ?? appColor.white,
      ),
    );
  }
}
