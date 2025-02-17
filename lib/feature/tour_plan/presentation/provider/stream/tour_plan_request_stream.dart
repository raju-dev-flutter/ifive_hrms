import 'package:ifive_hrms/core/core.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../feature.dart';

class TourPlanRequestStream {
  final _tourPlanLinesList = BehaviorSubject<List<TourPlanModel>>.seeded([]);
  final _selectedMonth = BehaviorSubject<String>.seeded('');

  final _selectedDateTime = BehaviorSubject<DateTime>.seeded(DateTime.now());

  final _beatList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _tourPlanList = BehaviorSubject<List<CommonList>>.seeded([]);

  Stream<List<TourPlanModel>> get tourPlanLinesList =>
      _tourPlanLinesList.stream;

  ValueStream<String> get selectedMonth => _selectedMonth.stream;

  ValueStream<DateTime> get selectedDateTime => _selectedDateTime.stream;

  ValueStream<List<CommonList>> get beatList => _beatList.stream;

  ValueStream<List<CommonList>> get tourPlanList => _tourPlanList.stream;

  Future<void> fetchInitialCallBack() async {
    _tourPlanList.sink.add([
      CommonList(id: 1, name: "Market"),
      CommonList(id: 2, name: "Leave"),
      CommonList(id: 3, name: "Meeting"),
      CommonList(id: 4, name: "Holiday"),
      CommonList(id: 5, name: "Weekly Off"),
    ]);
    _beatList.sink.add([
      CommonList(id: 1, name: "Market"),
      CommonList(id: 2, name: "Leave"),
      CommonList(id: 3, name: "Meeting"),
    ]);

    final List<TourPlanModel> tourPlan = [];
    DateTime now = DateTime.now();

    int nextMonth = (now.month % 12) + 1;
    int year = (nextMonth == 1) ? now.year + 1 : now.year;

    DateTime date = DateTime(year, nextMonth, now.day);
    String formattedDate = DateFormat('MMMM - yyyy').format(date);
    _selectedMonth.sink.add(formattedDate);

    final result = getDayAndDate(year, nextMonth);
    List<String> dates = result.$1;
    List<String> days = result.$2;

    for (var p = 0; p < dates.length; p++) {
      TourPlanModel tp = TourPlanModel(
          date: dates[p],
          day: days[p],
          tourTypeListInit: CommonList(),
          beatListInit: CommonList());
      tourPlan.add(tp);
    }

    _tourPlanLinesList.sink.add(tourPlan);
  }

  (List<String> date, List<String> day) getDayAndDate(int year, int month) {
    int daysInMonth = DateTime(year, month + 1, 0).day;

    List<String> dates = [];
    List<String> days = [];
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime fDate = DateTime(year, month, day);
      String _date = DateFormat('dd').format(fDate);
      String _day =
          DateFormat('EEEE').format(fDate).substring(0, 3).toUpperCase();
      dates.add(_date);
      days.add(_day);
    }

    return (dates, days);
  }

  void selectDateTime(DateTime dt) async {
    final List<TourPlanModel> tourPlan = [];
    _selectedDateTime.sink.add(dt);

    DateTime date = DateTime(dt.year, dt.month, dt.day);
    String formattedDate = DateFormat('MMMM - yyyy').format(date);
    _selectedMonth.sink.add(formattedDate);

    final result = getDayAndDate(dt.year, dt.month);
    List<String> dates = result.$1;
    List<String> days = result.$2;

    for (var p = 0; p < dates.length; p++) {
      TourPlanModel tp = TourPlanModel(
          date: dates[p],
          day: days[p],
          tourTypeListInit: CommonList(),
          beatListInit: CommonList());
      tourPlan.add(tp);
    }

    _tourPlanLinesList.sink.add(tourPlan);
  }

  void tourType(dynamic params, int position) {
    final List<TourPlanModel> otp = _tourPlanLinesList.valueOrNull ?? [];
    final tourTypeListInit = CommonList(id: params.id, name: params.name);
    if (position >= 0 && position < otp.length) {
      TourPlanModel current = otp[position];

      current = TourPlanModel(
        date: current.date,
        day: current.day,
        tourTypeListInit: tourTypeListInit,
        beatListInit: current.beatListInit,
      );

      otp[position] = current;
    }
    _tourPlanLinesList.sink.add(otp);
  }

  void beat(dynamic params, int position) {
    final List<TourPlanModel> otp = _tourPlanLinesList.valueOrNull ?? [];
    final beatInit = CommonList(id: params.id, name: params.name);
    if (position >= 0 && position < otp.length) {
      TourPlanModel current = otp[position];

      current = TourPlanModel(
        date: current.date,
        day: current.day,
        tourTypeListInit: current.tourTypeListInit,
        beatListInit: beatInit,
      );

      otp[position] = current;
    }
    _tourPlanLinesList.sink.add(otp);
  }

  Future<void> onSave() async {}

  Future<void> onClear() async {}
}
