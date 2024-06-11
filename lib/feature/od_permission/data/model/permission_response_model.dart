import '../../../../core/core.dart';

class PermissionResponseModel {
  List<PermissionResponse> permissionList = [];

  PermissionResponseModel.fromJson(DataMap json) {
    if (json['leavelist'] != null) {
      permissionList = <PermissionResponse>[];
      json['leavelist'].forEach((v) {
        permissionList.add(PermissionResponse.fromJson(v));
      });
    }
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    data['leavelist'] = permissionList.map((v) => v.toJson()).toList();
    return data;
  }
}

class PermissionResponse {
  String? employeeId;
  String? username;
  int? odPermissionId;
  String? type;
  String? inTime;
  String? outTime;
  String? date;
  String? duration;
  int? noOfMinutes;
  String? reason;
  String? reason1;
  String? inOut;
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
  String? branchId;
  String? approveBtnVal;
  String? lookupMeaning;
  String? reportname;

  PermissionResponse({
    this.employeeId,
    this.username,
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
    this.approveBtnVal,
    this.lookupMeaning,
    this.reportname,
  });

  PermissionResponse.fromJson(DataMap json) {
    employeeId = json['employee_id'];
    username = json['username'];
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
    approveBtnVal = json['approve_btn_val'];
    lookupMeaning = json['lookup_meaning'];
    reportname = json['reportname'];
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['username'] = username;
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
    data['approve_btn_val'] = approveBtnVal;
    data['lookup_meaning'] = lookupMeaning;
    data['reportname'] = reportname;
    return data;
  }
}
