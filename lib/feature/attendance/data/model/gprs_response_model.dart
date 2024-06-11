class GPRSResponseModel {
  int? empType;
  String? enableGpsRestriction;
  String? latitude;
  String? longitude;
  int? meter;

  GPRSResponseModel(
      {this.empType,
      this.enableGpsRestriction,
      this.latitude,
      this.longitude,
      this.meter});

  GPRSResponseModel.fromJson(Map<String, dynamic> json) {
    empType = json['emp_type'];
    enableGpsRestriction = json['enable_gps_restriction'];
    latitude = json['latitude'];
    longitude = json['longtitude'];
    meter = json['meter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp_type'] = empType;
    data['enable_gps_restriction'] = enableGpsRestriction;
    data['latitude'] = latitude;
    data['longtitude'] = longitude;
    data['meter'] = meter;
    return data;
  }
}
