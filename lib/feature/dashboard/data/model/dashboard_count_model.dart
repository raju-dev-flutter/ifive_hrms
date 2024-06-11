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
  int? foodCount;
  int? leave;

  DashboardCount({this.present, this.foodCount, this.leave});

  DashboardCount.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    foodCount = json['food_count'];
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present'] = present;
    data['food_count'] = foodCount;
    data['leave'] = leave;
    return data;
  }
}
