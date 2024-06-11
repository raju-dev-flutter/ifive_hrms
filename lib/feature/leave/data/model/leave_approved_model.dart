import '../../../../core/core.dart';

class LeaveApprovedModel {
  List<Leavelist>? leavelist;

  LeaveApprovedModel({this.leavelist});

  LeaveApprovedModel.fromJson(Map<String, dynamic> json) {
    if (json['leavelist'] != null) {
      leavelist = <Leavelist>[];
      json['leavelist'].forEach((v) {
        leavelist!.add(Leavelist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leavelist != null) {
      data['leavelist'] = leavelist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leavelist {
  int? employeeId;
  String? username;
  int? leaveId;
  String? startDate;
  String? endDate;
  String? startDateTime;
  String? endDateTime;
  dynamic noOfDays;
  dynamic allotedDays;
  String? noOfHrs;
  dynamic allotedHrs;
  int? leaveType;
  int? leaveMode;
  String? leaveStatus;
  String? leaveReason;
  String? forwardedId;
  String? approvalReason;
  String? approvelComments;
  int? organizationId;
  String? odStartDate;
  String? odEndDate;
  int? odNoOfDays;
  int? odAllotedDays;
  String? createdAt;
  String? updatedAt;
  int? projectId;
  int? createdBy;
  int? lastUpdatedBy;
  int? companyId;
  int? locationId;
  dynamic leaveCombo;
  String? dates;
  String? approverLevel;
  dynamic approvedBy;
  dynamic cancelledBy;
  dynamic cancelledAt;
  String? cancelComments;
  String? approveBtnVal;
  int? availableLeave;
  String? lookupMeaning;
  String? leavemode;
  String? reportname;

  Leavelist(
      {this.employeeId,
      this.username,
      this.leaveId,
      this.startDate,
      this.endDate,
      this.noOfDays,
      this.availableLeave,
      this.approveBtnVal,
      this.allotedDays,
      this.leaveType,
      this.leaveMode,
      this.leaveStatus,
      this.leaveReason,
      this.forwardedId,
      this.approvalReason,
      this.approvelComments,
      this.organizationId,
      this.odStartDate,
      this.odEndDate,
      this.odNoOfDays,
      this.odAllotedDays,
      this.createdAt,
      this.updatedAt,
      this.projectId,
      this.createdBy,
      this.lastUpdatedBy,
      this.companyId,
      this.locationId,
      this.lookupMeaning,
      this.leavemode,
      this.reportname});

  Leavelist.fromJson(DataMap json) {
    employeeId = json['employee_id'];
    username = json['username'];
    leaveId = json['leave_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    noOfDays = json['no_of_days'];
    availableLeave = json['available_leave'];
    approveBtnVal = json['approve_btn_val'];
    allotedDays = json['alloted_days'];
    leaveType = json['leave_type'];
    leaveMode = json['leave_mode'];
    leaveStatus = json['leave_status'];
    leaveReason = json['leave_reason'];
    forwardedId = json['forwarded_id'];
    approvalReason = json['approval_reason'];
    approvelComments = json['approvel_comments'];
    organizationId = json['organization_id'];
    odStartDate = json['od_start_date'];
    odEndDate = json['od_end_date'];
    odNoOfDays = json['od_no_of_days'];
    odAllotedDays = json['od_alloted_days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    projectId = json['project_id'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    lookupMeaning = json['lookup_meaning'];
    leavemode = json['leavemode'];
    reportname = json['reportname'];
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['username'] = username;
    data['leave_id'] = leaveId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['no_of_days'] = noOfDays;
    data['approve_btn_val'] = approveBtnVal;
    data['alloted_days'] = allotedDays;
    data['leave_type'] = leaveType;
    data['leave_mode'] = leaveMode;
    data['leave_status'] = leaveStatus;
    data['leave_reason'] = leaveReason;
    data['forwarded_id'] = forwardedId;
    data['approval_reason'] = approvalReason;
    data['approvel_comments'] = approvelComments;
    data['organization_id'] = organizationId;
    data['od_start_date'] = odStartDate;
    data['od_end_date'] = odEndDate;
    data['od_no_of_days'] = odNoOfDays;
    data['od_alloted_days'] = odAllotedDays;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['project_id'] = projectId;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['available_leave'] = availableLeave;
    data['lookup_meaning'] = lookupMeaning;
    data['leavemode'] = leavemode;
    data['reportname'] = reportname;
    return data;
  }
}
