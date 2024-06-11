class LeavesHistoryModel {
  List<LeavesHistory>? leavesHistory;

  LeavesHistoryModel({this.leavesHistory});

  LeavesHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['leavehistory'] != null) {
      leavesHistory = <LeavesHistory>[];
      json['leavehistory'].forEach((v) {
        leavesHistory!.add(LeavesHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leavesHistory != null) {
      data['leavehistory'] = leavesHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeavesHistory {
  String? startDate;
  String? endDate;
  String? leaveReason;

  LeavesHistory({this.startDate, this.endDate, this.leaveReason});

  LeavesHistory.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    leaveReason = json['leave_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['leave_reason'] = leaveReason;
    return data;
  }
}
