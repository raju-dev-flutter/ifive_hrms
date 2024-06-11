class DashboardResponseModel {
  List<UserDataModel>? userData;
  String? attCount;
  String? poValue;
  String? soValue;
  int? soYmd;
  int? soAvg;
  int? soToday;
  int? poYmd;
  int? poAvg;
  int? poToday;

  DashboardResponseModel(
      {this.userData,
      this.attCount,
      this.poValue,
      this.soValue,
      this.soYmd,
      this.soAvg,
      this.soToday,
      this.poYmd,
      this.poAvg,
      this.poToday});

  DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['user_data'] != null) {
      userData = <UserDataModel>[];
      json['user_data'].forEach((v) {
        userData!.add(UserDataModel.fromJson(v));
      });
    }
    attCount = json['att_count'];
    poValue = json['po_value'];
    soValue = json['so_value'];
    soYmd = json['so_ymd'];
    soAvg = json['so_avg'];
    soToday = json['so_today'];
    poYmd = json['po_ymd'];
    poAvg = json['po_avg'];
    poToday = json['po_today'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['user_data'] = userData!.map((v) => v.toJson()).toList();
    }
    data['att_count'] = attCount;
    data['po_value'] = poValue;
    data['so_value'] = soValue;
    data['so_ymd'] = soYmd;
    data['so_avg'] = soAvg;
    data['so_today'] = soToday;
    data['po_ymd'] = poYmd;
    data['po_avg'] = poAvg;
    data['po_today'] = poToday;
    return data;
  }
}

class UserDataModel {
  String? empName;
  int? empId;
  String? checkIn;
  String? beatName;
  int? oCount;
  int? olCount;
  int? vcCount;
  int? oValue;

  UserDataModel(
      {this.empName,
      this.empId,
      this.checkIn,
      this.beatName,
      this.oCount,
      this.olCount,
      this.vcCount,
      this.oValue});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    empId = json['emp_id'];
    checkIn = json['check_in'];
    beatName = json['beat_name'];
    oCount = json['o_count'];
    olCount = json['ol_count'];
    vcCount = json['vc_count'];
    oValue = json['o_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp_name'] = empName;
    data['emp_id'] = empId;
    data['check_in'] = checkIn;
    data['beat_name'] = beatName;
    data['o_count'] = oCount;
    data['ol_count'] = olCount;
    data['vc_count'] = vcCount;
    data['o_value'] = oValue;
    return data;
  }
}
