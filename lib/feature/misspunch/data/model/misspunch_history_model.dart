class MisspunchHistoryModel {
  List<MisspunchHistory>? misspunchhistory;

  MisspunchHistoryModel({this.misspunchhistory});

  MisspunchHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['misspunchhistory'] != null) {
      misspunchhistory = <MisspunchHistory>[];
      json['misspunchhistory'].forEach((v) {
        misspunchhistory!.add(MisspunchHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (misspunchhistory != null) {
      data['misspunchhistory'] =
          misspunchhistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MisspunchHistory {
  int? missId;
  String? employeeId;
  String? misspunch;
  String? inTime;
  String? outTime;
  String? date;
  String? time;
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
  int? lookuplinesId;
  int? lookuphdrId;
  String? lookupCode;
  String? lookupMeaning;
  String? description;
  int? sequence;
  String? active;
  String? lookupType;
  int? organizationId;
  int? lineNo;

  MisspunchHistory(
      {this.missId,
      this.employeeId,
      this.misspunch,
      this.inTime,
      this.outTime,
      this.date,
      this.time,
      this.reason,
      this.reason1,
      this.inOut,
      this.status,
      this.forwardedId,
      this.companyId,
      this.locationId,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.lastUpdatedBy,
      this.lookuplinesId,
      this.lookuphdrId,
      this.lookupCode,
      this.lookupMeaning,
      this.description,
      this.sequence,
      this.active,
      this.lookupType,
      this.organizationId,
      this.lineNo});

  MisspunchHistory.fromJson(Map<String, dynamic> json) {
    missId = json['miss_id'];
    employeeId = json['employee_id'];
    misspunch = json['misspunch'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    date = json['date'];
    time = json['time'];
    reason = json['reason'];
    reason1 = json['reason1'];
    inOut = json['in_out'];
    status = json['status'];
    forwardedId = json['forwarded_id'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastUpdatedBy = json['last_updated_by'];
    lookuplinesId = json['lookuplines_id'];
    lookuphdrId = json['lookuphdr_id'];
    lookupCode = json['lookup_code'];
    lookupMeaning = json['lookup_meaning'];
    description = json['description'];
    sequence = json['sequence'];
    active = json['active'];
    lookupType = json['lookup_type'];
    organizationId = json['organization_id'];
    lineNo = json['line_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['miss_id'] = missId;
    data['employee_id'] = employeeId;
    data['misspunch'] = misspunch;
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    data['date'] = date;
    data['time'] = time;
    data['reason'] = reason;
    data['reason1'] = reason1;
    data['in_out'] = inOut;
    data['status'] = status;
    data['forwarded_id'] = forwardedId;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_updated_by'] = lastUpdatedBy;
    data['lookuplines_id'] = lookuplinesId;
    data['lookuphdr_id'] = lookuphdrId;
    data['lookup_code'] = lookupCode;
    data['lookup_meaning'] = lookupMeaning;
    data['description'] = description;
    data['sequence'] = sequence;
    data['active'] = active;
    data['lookup_type'] = lookupType;
    data['organization_id'] = organizationId;
    data['line_no'] = lineNo;
    return data;
  }
}
