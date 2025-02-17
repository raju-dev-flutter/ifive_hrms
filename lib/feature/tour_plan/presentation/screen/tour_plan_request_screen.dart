import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../tour_plan.dart';

class TourPlanRequestScreen extends StatefulWidget {
  const TourPlanRequestScreen({super.key});

  @override
  State<TourPlanRequestScreen> createState() => _TourPlanRequestScreenState();
}

class _TourPlanRequestScreenState extends State<TourPlanRequestScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final tourPlanRequest = sl<TourPlanRequestStream>();

  @override
  void initState() {
    super.initState();
    tourPlanRequest.fetchInitialCallBack();
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
          title: "Tour Plan",
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
            stream: tourPlanRequest.selectedMonth,
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
                            tourPlanRequest.selectedDateTime.valueOrNull ??
                                DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 100),
                        onDateSelected: (dt) {
                          tourPlanRequest.selectDateTime(dt);
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
          child: _TourPlanRequestListWidget(tourPlanRequest: tourPlanRequest),
        ),
        Dimensions.kVerticalSpaceLargest,
      ],
    );
  }
}

class _TourPlanRequestListWidget extends StatelessWidget {
  final TourPlanRequestStream tourPlanRequest;

  const _TourPlanRequestListWidget({required this.tourPlanRequest});

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
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<TourPlanModel>>(
                stream: tourPlanRequest.tourPlanLinesList,
                builder: (context, snapshot) {
                  final data = snapshot.hasData && snapshot.data!.isNotEmpty
                      ? snapshot.data
                      : [];
                  return ListView.separated(
                    itemBuilder: (_, i) {
                      return _TourPlanLinesWidget(
                        tp: data[i],
                        tourTypeOnPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomContentPicker(
                                label: 'SELECT TOUR TYPE',
                                isSearch: true,
                                initialData:
                                    data[i].tourTypeListInit ?? CommonList(),
                                streamList:
                                    tourPlanRequest.tourPlanList.valueOrNull ??
                                        [],
                                onChanged: (CommonList data) {
                                  tourPlanRequest.tourType(data, i);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                        beatOnPressed: data[i].tourTypeListInit!.name != null &&
                                data[i].tourTypeListInit!.name != "" &&
                                data[i].tourTypeListInit!.name == "Market"
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomContentPicker(
                                      label: 'SELECT BEAT LIST',
                                      isSearch: true,
                                      initialData:
                                          data[i].beatListInit ?? CommonList(),
                                      streamList: tourPlanRequest
                                              .beatList.valueOrNull ??
                                          [],
                                      onChanged: (CommonList data) {
                                        tourPlanRequest.beat(data, i);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              }
                            : () {},
                      );
                    },
                    separatorBuilder: (_, i) {
                      return Dimensions.kDivider;
                    },
                    itemCount: data!.length,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _TourPlanLinesWidget extends StatelessWidget {
  final VoidCallback tourTypeOnPressed;
  final VoidCallback beatOnPressed;
  final TourPlanModel tp;

  const _TourPlanLinesWidget(
      {required this.tourTypeOnPressed,
      required this.beatOnPressed,
      required this.tp});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _TourPlanTextWidget(
            text: tp.date ?? "",
            color: appColor.gray900,
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 2,
          child: _TourPlanTextWidget(
            text: tp.day ?? "",
            color: appColor.gray900,
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: tourTypeOnPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12).w,
              child: _TourPlanTextWidget(
                text: tp.tourTypeListInit?.name ?? "--SELECT--",
                color: appColor.gray900,
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: beatOnPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12).w,
              child: _TourPlanTextWidget(
                text: tp.beatListInit?.name ?? "--SELECT--",
                color: appColor.gray900,
              ),
            ),
          ),
        ),
      ],
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
