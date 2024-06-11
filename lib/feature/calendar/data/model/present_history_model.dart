class PresentHistoryModel {
  List<PresentHistory>? presentHistory;

  WeekOff? weekOff;

  PresentHistoryModel({this.presentHistory, this.weekOff});

  PresentHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['present_history'] != null) {
      presentHistory = <PresentHistory>[];
      json['present_history'].forEach((v) {
        presentHistory!.add(PresentHistory.fromJson(v));
      });
    }
    weekOff =
        json['week_off'] != null ? WeekOff.fromJson(json['week_off']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (presentHistory != null) {
      data['present_history'] = presentHistory!.map((v) => v.toJson()).toList();
    }
    if (weekOff != null) {
      data['week_off'] = weekOff!.toJson();
    }
    return data;
  }
}

class PresentHistory {
  String? title;
  String? start;

  PresentHistory({this.title, this.start});

  PresentHistory.fromJson(Map<String, dynamic> json) {
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

class WeekOff {
  int? empPayrollSettingsId;
  int? employeeType;
  String? weekOff;
  String? monthOff;
  String? weekPeriod;
  dynamic otCalculation;
  dynamic officeHours;
  int? status;
  dynamic shiftType;
  dynamic startTime;
  dynamic endTime;
  dynamic breakHours;
  String? createdBy;
  String? createdDate;
  dynamic lastUpdatedBy;
  dynamic lastUpdatedDate;
  int? companyId;
  int? organizationId;
  int? locationId;

  WeekOff(
      {this.empPayrollSettingsId,
      this.employeeType,
      this.weekOff,
      this.monthOff,
      this.weekPeriod,
      this.otCalculation,
      this.officeHours,
      this.status,
      this.shiftType,
      this.startTime,
      this.endTime,
      this.breakHours,
      this.createdBy,
      this.createdDate,
      this.lastUpdatedBy,
      this.lastUpdatedDate,
      this.companyId,
      this.organizationId,
      this.locationId});

  WeekOff.fromJson(Map<String, dynamic> json) {
    empPayrollSettingsId = json['emp_payroll_settings_id'];
    employeeType = json['employee_type'];
    weekOff = json['week_off'];
    monthOff = json['month_off'];
    weekPeriod = json['week_period'];
    otCalculation = json['ot_calculation'];
    officeHours = json['office_hours'];
    status = json['status'];
    shiftType = json['shift_type'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    breakHours = json['break_hours'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    lastUpdatedBy = json['last_updated_by'];
    lastUpdatedDate = json['last_updated_date'];
    companyId = json['company_id'];
    organizationId = json['organization_id'];
    locationId = json['location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp_payroll_settings_id'] = empPayrollSettingsId;
    data['employee_type'] = employeeType;
    data['week_off'] = weekOff;
    data['month_off'] = monthOff;
    data['week_period'] = weekPeriod;
    data['ot_calculation'] = otCalculation;
    data['office_hours'] = officeHours;
    data['status'] = status;
    data['shift_type'] = shiftType;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['break_hours'] = breakHours;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['last_updated_by'] = lastUpdatedBy;
    data['last_updated_date'] = lastUpdatedDate;
    data['company_id'] = companyId;
    data['organization_id'] = organizationId;
    data['location_id'] = locationId;
    return data;
  }
}
