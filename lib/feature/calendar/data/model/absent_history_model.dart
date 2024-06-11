class AbsentHistoryModel {
  List<AbsentHistory>? absentHistory;

  AbsentHistoryModel({this.absentHistory});

  AbsentHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['absent_history'] != null) {
      absentHistory = <AbsentHistory>[];
      json['absent_history'].forEach((v) {
        absentHistory!.add(AbsentHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (absentHistory != null) {
      data['absent_history'] = absentHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AbsentHistory {
  String? title;
  String? start;

  AbsentHistory({this.title, this.start});

  AbsentHistory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['start'] = start;
    return data;
  }
}
