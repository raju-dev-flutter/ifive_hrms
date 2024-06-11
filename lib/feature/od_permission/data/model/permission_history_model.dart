class PermissionHistoryModel {
  List<Odphistory>? odphistory;

  PermissionHistoryModel({this.odphistory});

  PermissionHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['odphistory'] != null) {
      odphistory = <Odphistory>[];
      json['odphistory'].forEach((v) {
        odphistory!.add(Odphistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (odphistory != null) {
      data['odphistory'] = odphistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Odphistory {
  String? username;
  String? employeeId;
  int? odPermissionId;
  String? type;
  String? inTime;
  String? outTime;
  String? date;
  String? duration;
  int? noOfMinutes;
  String? reason;
  String? reason1;
  dynamic inOut;
  String? status;
  String? cancelComments;
  String? forwardedId;
  int? companyId;
  int? locationId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  int? lastUpdatedBy;
  String? inDatetime;
  String? outDatetime;
  int? shiftId;
  dynamic branchId;
  dynamic rejectRemark;
  String? permissionType;
  String? reportname;

  Odphistory(
      {this.username,
      this.employeeId,
      this.odPermissionId,
      this.type,
      this.inTime,
      this.outTime,
      this.date,
      this.duration,
      this.noOfMinutes,
      this.reason,
      this.reason1,
      this.inOut,
      this.status,
      this.cancelComments,
      this.forwardedId,
      this.companyId,
      this.locationId,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.lastUpdatedBy,
      this.inDatetime,
      this.outDatetime,
      this.shiftId,
      this.branchId,
      this.rejectRemark,
      this.permissionType,
      this.reportname});

  Odphistory.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    employeeId = json['employee_id'];
    odPermissionId = json['od_permission_id'];
    type = json['type'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    date = json['date'];
    duration = json['duration'];
    noOfMinutes = json['no_of_minutes'];
    reason = json['reason'];
    reason1 = json['reason1'];
    inOut = json['in_out'];
    status = json['status'];
    cancelComments = json['cancel_comments'];
    forwardedId = json['forwarded_id'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastUpdatedBy = json['last_updated_by'];
    inDatetime = json['in_datetime'];
    outDatetime = json['out_datetime'];
    shiftId = json['shift_id'];
    branchId = json['branch_id'];
    rejectRemark = json['reject_remark'];
    permissionType = json['permission_type'];
    reportname = json['reportname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['employee_id'] = employeeId;
    data['od_permission_id'] = odPermissionId;
    data['type'] = type;
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    data['date'] = date;
    data['duration'] = duration;
    data['no_of_minutes'] = noOfMinutes;
    data['reason'] = reason;
    data['reason1'] = reason1;
    data['in_out'] = inOut;
    data['status'] = status;
    data['cancel_comments'] = cancelComments;
    data['forwarded_id'] = forwardedId;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_updated_by'] = lastUpdatedBy;
    data['in_datetime'] = inDatetime;
    data['out_datetime'] = outDatetime;
    data['shift_id'] = shiftId;
    data['branch_id'] = branchId;
    data['reject_remark'] = rejectRemark;
    data['permission_type'] = permissionType;
    data['reportname'] = reportname;
    return data;
  }
}
