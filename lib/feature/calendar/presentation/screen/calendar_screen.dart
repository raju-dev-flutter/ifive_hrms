import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../dashboard/dashboard.dart';
import '../../../root/root.dart';
import '../provider/stream/calendar_stream.dart';

class CalendarScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const CalendarScreen({super.key, required this.scaffold});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarController _calendarController = CalendarController();
  late _AppointmentDataSource _dataSource;

  final calendarStream = sl<CalendarStream>();
  List<Appointment> appointments = <Appointment>[];

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  @override
  void initState() {
    _calendarController = CalendarController();
    _dataSource = _getCalendarDataSource();
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    final token = SharedPrefs().getToken();
    BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
        .getAttendanceStatus(token);
  }

  _AppointmentDataSource _getCalendarDataSource() {
    // initialCallBack();
    appointments.clear();
    calendarStream
        .fetchInitialCallBack(DateFormat('yyyy-MM-dd').format(fromDate),
            DateFormat('yyyy-MM-dd').format(toDate))
        .then((responses) {
      for (var response in responses) {
        setState(() {});
        setState(() => appointments.add(response));
        // Logger().i("Res: ${response.subject}");
      }
      // Logger().i("Res Length: ${appointments.length}");
      return _AppointmentDataSource(appointments);
    });
    setState(() {});
    return _AppointmentDataSource(appointments);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceStatusCubit, AttendanceStatusState>(
      listener: (context, state) {
        if (state is AttendanceStatusFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
            BlocProvider.of<NavigationCubit>(context)
                .getNavBarItem(NavbarItem.home);
          }
        }
      },
      child: Column(
        children: [
          Expanded(
              flex: 1, child: DashboardHeaderWidget(scaffold: widget.scaffold)),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                filterCardUI(),
                Expanded(
                  child: SfCalendar(
                    view: CalendarView.month,
                    controller: _calendarController,
                    showNavigationArrow: true,
                    showTodayButton: true,
                    showDatePickerButton: true,
                    headerHeight: 60,
                    dataSource: _AppointmentDataSource(appointments),
                    timeSlotViewSettings: const TimeSlotViewSettings(
                        nonWorkingDays: <int>[DateTime.sunday]),
                    onTap: (CalendarTapDetails details) {
                      if (details.appointments!.isNotEmpty &&
                          details.appointments != null) {
                        final dynamic occurrenceAppointment =
                            details.appointments![0];
                        final Appointment? patternAppointment =
                            _dataSource.getPatternAppointment(
                                occurrenceAppointment, '') as Appointment?;
                      }
                    },
                    headerStyle: const CalendarHeaderStyle(
                        backgroundColor: Colors.transparent),
                    selectionDecoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: Dimensions.kBorderRadiusAllSmallest,
                      border: Border(
                          bottom:
                              BorderSide(color: appColor.brand800, width: 2)),
                    ),
                    onViewChanged: (ViewChangedDetails details) {
                      List<DateTime> dates = details.visibleDates;
                      String calendarTimeZone = '';
                      List<Object> appointment =
                          _dataSource.getVisibleAppointments(
                              dates[0],
                              calendarTimeZone,
                              dates[(details.visibleDates.length) - 1]);
                    },
                    monthViewSettings: const MonthViewSettings(
                        showAgenda: true, monthCellStyle: MonthCellStyle()),
                  ),
                ),
                Container(
                  padding: Dimensions.kPaddingAllMedium,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      calendarIndicator(
                          color: appColor.error600, label: 'ABSENT'),
                      calendarIndicator(
                          color: const Color(0xFF66C61C), label: 'PRESENT'),
                      calendarIndicator(
                          color: const Color(0xFF22CCEE), label: 'LEAVE'),
                      calendarIndicator(
                          color: const Color(0xFFFAC515), label: 'HALF DAY'),
                      calendarIndicator(
                          color: const Color(0xFFFF692E), label: 'MISSPUNCH'),
                      calendarIndicator(
                          color: const Color(0xFFD444F1), label: 'HOLIDAYS'),
                      calendarIndicator(
                          color: const Color(0xFFD6D6D6), label: 'WEEK OFF'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget calendarIndicator({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: Dimensions.kBorderRadiusAllLarge,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: appColor.brand800,
            // fontSize: 8,
          ),
        ),
      ],
    );
  }

  Widget filterCardUI() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2).w,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: fromDate, startDate: null);
                setState(() => fromDate = date);
                _getCalendarDataSource();
              },
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd').format(fromDate),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray950,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter:
                          ColorFilter.mode(appColor.white, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: toDate, startDate: null);
                setState(() => toDate = date);
                _getCalendarDataSource();
              },
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd').format(toDate),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray950,
                        // fontSize: 8,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter:
                          ColorFilter.mode(appColor.gray700, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(width: 4.w),
          // InkWell(
          //   onTap: _getCalendarDataSource,
          //   borderRadius: Dimensions.kBorderRadiusAllSmallest,
          //   child: Container(
          //     width: 38,
          //     height: 38,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: appColor.gray300,
          //       borderRadius: Dimensions.kBorderRadiusAllSmallest,
          //     ),
          //     child: SvgPicture.asset(
          //       AppSvg.search,
          //       width: 14,
          //       colorFilter: ColorFilter.mode(appColor.white, BlendMode.srcIn),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      border: Border.all(width: 1, color: appColor.gray300),
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  String getStartTimeZone(int index) {
    return appointments![index].startTimeZone;
  }

  @override
  String getEndTimeZone(int index) {
    return appointments![index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}
