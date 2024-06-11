import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class PickDateTime {
  static Future<dynamic> time(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      return picked;
    }
    return currentTime;
  }

  static Future<dynamic> date(BuildContext context,
      {required DateTime? selectedDate,
      DateTime? startDate,
      DateTime? endDate}) async {
    DateTime currentDate = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: startDate ?? DateTime(1900),
      lastDate: endDate ?? DateTime(2100),
    );

    if (pickedDate != null) {
      return pickedDate;
    }
    return currentDate;
  }

  static String dateAndTimeFormat(
      {required String date, required String time}) {
    String inputDateTime = '$date $time';
    DateTime parsedDateTime =
        DateFormat("yyyy-MM-dd hh:mm a").parse(inputDateTime);
    String formattedDateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(parsedDateTime);

    return formattedDateTime;
  }

  static String format12Time(TimeOfDay timeOfDay) {
    int hour = timeOfDay.hourOfPeriod;
    int minute = timeOfDay.minute;
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    String formattedTime =
        '${hour == 0 ? '12' : hour > 12 ? '${hour - 12}' : hour.toString()}:${minute.toString().padLeft(2, '0')} $period';

    return formattedTime;
  }

  bool checkAvailableTime(TimeOfDay time) {
    TimeOfDay openingTime = const TimeOfDay(hour: 00, minute: 00);
    TimeOfDay closingTime = const TimeOfDay(hour: 10, minute: 01);

    int shopOpenTimeInSeconds = openingTime.hour * 60 + openingTime.minute;
    int shopCloseTimeInSeconds = closingTime.hour * 60 + closingTime.minute;
    int timeNowInSeconds = time.hour * 60 + time.minute;

    if (shopOpenTimeInSeconds <= timeNowInSeconds &&
        timeNowInSeconds <= shopCloseTimeInSeconds) {
      return true;
    } else {
      return false;
    }
  }

  static int noOfDays(DateTime? from, DateTime? to) {
    final current = DateTime.now();
    var addDay = from == null || to == null ? 0 : 1;
    from = from == null
        ? DateTime.utc(current.year, current.month, current.day)
        : DateTime.utc(from.year, from.month, from.day);
    to = to == null
        ? DateTime.utc(current.year, current.month, current.day)
        : DateTime.utc(to.year, to.month, to.day);

    return to.difference(from).inDays + addDay;
  }

  static int noOfLeaveDays(DateTime? from, DateTime? to) {
    if (from == null || to == null) {
      return 0;
    }
    int days = to.difference(from).inDays;
    int sundays = 0;
    int secondSaturday = 0;
    int fourthSaturday = 0;
    for (int i = 0; i <= days;) {
      DateTime date = from.add(Duration(days: i));
      if (date.weekday == DateTime.sunday) {
        sundays++;
      }
      if (date.weekday == DateTime.saturday) {
        // Second and fourth Saturdays
        int weekOfMonth = (date.day - 1) ~/ 7 + 1;
        if (weekOfMonth == 2) {
          secondSaturday++;
        } else if (weekOfMonth == 4) {
          fourthSaturday++;
        }
      }
      // Subtract Sundays, second and fourth Saturdays from the total duration
      return days - sundays - secondSaturday - fourthSaturday;
    }

    return 0;
  }

  static String calculateTimeInterval(DateTime? fromDate, TimeOfDay? fromTime,
      DateTime? toDate, TimeOfDay? toTime) {
    final current = DateTime.now();

    DateTime startTime = fromDate == null
        ? current
        : DateTime(fromDate.year, fromDate.month, fromDate.day, fromTime!.hour,
            fromTime.minute);
    DateTime endTime = toDate == null
        ? current
        : DateTime(
            toDate.year, toDate.month, toDate.day, toTime!.hour, toTime.minute);

    Duration timeInterval = endTime.difference(startTime);

    Logger().i(
        'Time interval:${timeInterval.inHours}  == ${timeInterval.inHours} hours and ${timeInterval.inMinutes % 60} minutes');
    return fromDate == null || toDate == null
        ? "00:00"
        : timeInterval.toString().split(".")[0];
  }

  static String calculateAge(DateTime? dob) {
    DateTime today = DateTime.now();
    if (dob != null) {
      // int age = today.year - dob.year;
      // int months = today.month - dob.month;
      // int days = today.day - dob.day;
      //
      // if (months < 0 || (months == 0 && days < 0)) {
      //   age--;
      // }
      //
      // int ageInDays = today.difference(dob).inDays;
      // int ageInMonths = (ageInDays / 30).floor();
      Duration difference = today.difference(dob);
      int age = (difference.inDays / 365).floor();
      return '$age';
    }
    return '0';
  }
}
