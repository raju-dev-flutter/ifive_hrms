class DashboardCountModel {
  DashboardCount? counts;

  DashboardCountModel({this.counts});

  DashboardCountModel.fromJson(Map<String, dynamic> json) {
    counts =
        json['counts'] != null ? DashboardCount.fromJson(json['counts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (counts != null) {
      data['counts'] = counts!.toJson();
    }
    return data;
  }
}

class DashboardCount {
  int? present;
  int? renewalTracking;
  int? renewalExpiry;
  int? renewalOverDue;
  int? renewalActive;
  int? foodCount;
  int? leave;

  DashboardCount(
      {this.present,
      this.foodCount,
      this.leave,
      this.renewalExpiry,
      this.renewalOverDue,
      this.renewalActive});

  DashboardCount.fromJson(Map<String, dynamic> json) {
    renewalTracking = json['renewal_tracking'];
    renewalExpiry = json['renewal_expiry'];
    renewalOverDue = json['renewal_over_due'];
    renewalActive = json['renewal_active'];
    present = json['present'];
    foodCount = json['food_count'];
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['renewal_tracking'] = renewalTracking;
    data['renewal_expiry'] = renewalExpiry;
    data['renewal_over_due'] = renewalOverDue;
    data['renewal_active'] = renewalActive;
    data['present'] = present;
    data['food_count'] = foodCount;
    data['leave'] = leave;
    return data;
  }
}
