class MisspunchApprovedModel {
  List<MisspunchApproved>? misspunchApproved;

  MisspunchApprovedModel({this.misspunchApproved});

  MisspunchApprovedModel.fromJson(Map<String, dynamic> json) {
    if (json['misspunchlist'] != null) {
      misspunchApproved = <MisspunchApproved>[];
      json['misspunchlist'].forEach((v) {
        misspunchApproved!.add(MisspunchApproved.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (misspunchApproved != null) {
      data['misspunchlist'] =
          misspunchApproved!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MisspunchApproved {
  String? username;
  int? missId;
  String? employeeId;
  String? misspunch;
  String? inTime;
  String? outTime;
  String? date;
  String? time;
  String? reason;
  String? reason1;
  String? inOut;
  String? status;
  String? forwardedId;
  int? companyId;
  int? locationId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? lookmean;

  MisspunchApproved({
    this.username,
    this.missId,
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
    this.lookmean,
  });

  MisspunchApproved.fromJson(Map<String, dynamic> json) {
    username = json['username'];
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
    lookmean = json['lookup_meaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['username'] = username;
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
    data['lookup_meaning'] = lookmean;
    return data;
  }
}
