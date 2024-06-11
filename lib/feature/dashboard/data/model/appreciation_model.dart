class AnnouncementResponseModel {
  List<AnnouncementResponse>? announcement;

  AnnouncementResponseModel({this.announcement});

  AnnouncementResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['announcement'] != null) {
      announcement = <AnnouncementResponse>[];
      json['announcement'].forEach((v) {
        announcement!.add(AnnouncementResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (announcement != null) {
      data['announcement'] = announcement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnnouncementResponse {
  int? employeeId;
  String? empName;
  String? announcementType;
  String? startDate;
  String? endDate;
  dynamic annId;
  String? text;
  String? dateOfBirth;
  String? dateOfJoining;
  String? tp;
  String? photo;

  AnnouncementResponse(
      {this.employeeId,
      this.empName,
      this.announcementType,
      this.startDate,
      this.endDate,
      this.annId,
      this.text,
      this.dateOfBirth,
      this.dateOfJoining,
      this.tp,
      this.photo});

  AnnouncementResponse.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    empName = json['emp_name'];
    announcementType = json['announcement_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    annId = json['ann_id'];
    text = json['text'];
    dateOfBirth = json['date_of_birth'];
    dateOfJoining = json['date_of_joining'];
    tp = json['tp'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['emp_name'] = empName;
    data['announcement_type'] = announcementType;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['ann_id'] = annId;
    data['text'] = text;
    data['date_of_birth'] = dateOfBirth;
    data['date_of_joining'] = dateOfJoining;
    data['tp'] = tp;
    data['photo'] = photo;
    return data;
  }
}
