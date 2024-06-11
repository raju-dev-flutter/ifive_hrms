class HolidayHistoryModel {
  List<HolidayHistory>? holidayHistory;

  HolidayHistoryModel({this.holidayHistory});

  HolidayHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['holidayhistory'] != null) {
      holidayHistory = <HolidayHistory>[];
      json['holidayhistory'].forEach((v) {
        holidayHistory!.add(HolidayHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (holidayHistory != null) {
      data['holidayhistory'] = holidayHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HolidayHistory {
  String? holidayName;
  String? date;

  HolidayHistory({this.holidayName, this.date});

  HolidayHistory.fromJson(Map<String, dynamic> json) {
    holidayName = json['holiday_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['holiday_name'] = holidayName;
    data['date'] = date;
    return data;
  }
}
