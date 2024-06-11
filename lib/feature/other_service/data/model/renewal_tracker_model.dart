class RenewalTrackerModel {
  List<RenewalTracker>? renewalTracker;

  RenewalTrackerModel({this.renewalTracker});

  RenewalTrackerModel.fromJson(Map<String, dynamic> json) {
    if (json['renewal_tracker_data'] != null) {
      renewalTracker = <RenewalTracker>[];
      json['renewal_tracker_data'].forEach((v) {
        renewalTracker!.add(RenewalTracker.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (renewalTracker != null) {
      data['renewal_tracker_data'] =
          renewalTracker!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RenewalTracker {
  String? nameOfDoc;
  String? docAction;
  String? departmentName;
  String? validTill;
  String? dueDate;
  String? status;

  RenewalTracker(
      {this.nameOfDoc,
      this.docAction,
      this.departmentName,
      this.validTill,
      this.dueDate,
      this.status});

  RenewalTracker.fromJson(Map<String, dynamic> json) {
    nameOfDoc = json['name_of_doc'];
    docAction = json['doc_action'];
    departmentName = json['department_name'];
    validTill = json['valid_till'];
    dueDate = json['due_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_of_doc'] = nameOfDoc;
    data['doc_action'] = docAction;
    data['department_name'] = departmentName;
    data['valid_till'] = validTill;
    data['due_date'] = dueDate;
    data['status'] = status;
    return data;
  }
}
