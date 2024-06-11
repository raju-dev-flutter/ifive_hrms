class ApprovalLeaveHistoryModel {
  List<LeaveApprovalList>? leaveApproval;

  ApprovalLeaveHistoryModel({this.leaveApproval});

  ApprovalLeaveHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['leave-approval-list'] != null) {
      leaveApproval = <LeaveApprovalList>[];
      json['leave-approval-list'].forEach((v) {
        leaveApproval!.add(LeaveApprovalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaveApproval != null) {
      data['leave-approval-list'] =
          leaveApproval!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveApprovalList {
  int? employeeId;
  String? employeeNumber;
  String? employeeName;
  int? leaveId;
  String? startDate;
  String? endDate;
  String? startDateTime;
  String? endDateTime;
  dynamic noOfDays;
  dynamic allotedDays;
  dynamic noOfHrs;
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
  String? odNoOfDays;
  String? odAllotedDays;
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
  String? leaveTypeName;
  String? leaveModeName;

  LeaveApprovalList(
      {this.employeeId,
      this.employeeNumber,
      this.employeeName,
      this.leaveId,
      this.startDate,
      this.endDate,
      this.startDateTime,
      this.endDateTime,
      this.noOfDays,
      this.allotedDays,
      this.noOfHrs,
      this.allotedHrs,
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
      this.leaveCombo,
      this.dates,
      this.approverLevel,
      this.approvedBy,
      this.cancelledBy,
      this.cancelledAt,
      this.cancelComments,
      this.leaveTypeName,
      this.leaveModeName});

  LeaveApprovalList.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeNumber = json['employee_number'];
    employeeName = json['employee_name'];
    leaveId = json['leave_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    noOfDays = json['no_of_days'];
    allotedDays = json['alloted_days'];
    noOfHrs = json['no_of_hrs'];
    allotedHrs = json['alloted_hrs'];
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
    leaveCombo = json['leave_combo'];
    dates = json['dates'];
    approverLevel = json['approver_level'];
    approvedBy = json['approved_by'];
    cancelledBy = json['cancelled_by'];
    cancelledAt = json['cancelled_at'];
    cancelComments = json['cancel_comments'];
    leaveTypeName = json['leave_type_name'];
    leaveModeName = json['leave_mode_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['employee_number'] = employeeNumber;
    data['employee_name'] = employeeName;
    data['leave_id'] = leaveId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_date_time'] = startDateTime;
    data['end_date_time'] = endDateTime;
    data['no_of_days'] = noOfDays;
    data['alloted_days'] = allotedDays;
    data['no_of_hrs'] = noOfHrs;
    data['alloted_hrs'] = allotedHrs;
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
    data['leave_combo'] = leaveCombo;
    data['dates'] = dates;
    data['approver_level'] = approverLevel;
    data['approved_by'] = approvedBy;
    data['cancelled_by'] = cancelledBy;
    data['cancelled_at'] = cancelledAt;
    data['cancel_comments'] = cancelComments;
    data['leave_type_name'] = this.leaveTypeName;
    data['leave_mode_name'] = this.leaveModeName;
    return data;
  }
}
