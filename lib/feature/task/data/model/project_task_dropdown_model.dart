import 'package:ifive_hrms/core/core.dart';

class ProjectTaskDropdownModel {
  List<CommonList>? project;
  List<CommonList>? leadResponse;
  List<CommonList>? approver;
  List<CommonList>? department;
  List<CommonList>? taskType;

  ProjectTaskDropdownModel(
      {this.project,
      this.leadResponse,
      this.approver,
      this.department,
      this.taskType});

  ProjectTaskDropdownModel.fromJson(Map<String, dynamic> json) {
    if (json['project'] != null) {
      project = <CommonList>[];
      json['project'].forEach((v) {
        project!.add(CommonList.fromJson(v));
      });
    }
    if (json['lead_response'] != null) {
      leadResponse = <CommonList>[];
      json['lead_response'].forEach((v) {
        leadResponse!.add(CommonList.fromJson(v));
      });
    }
    if (json['approver'] != null) {
      approver = <CommonList>[];
      json['approver'].forEach((v) {
        approver!.add(CommonList.fromJson(v));
      });
    }
    if (json['department'] != null) {
      department = <CommonList>[];
      json['department'].forEach((v) {
        department!.add(CommonList.fromJson(v));
      });
    }
    if (json['task_type'] != null) {
      taskType = <CommonList>[];
      json['task_type'].forEach((v) {
        taskType!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (project != null) {
      data['project'] = project!.map((v) => v.toJson()).toList();
    }
    if (leadResponse != null) {
      data['lead_response'] = leadResponse!.map((v) => v.toJson()).toList();
    }
    if (approver != null) {
      data['approver'] = approver!.map((v) => v.toJson()).toList();
    }
    if (department != null) {
      data['department'] = department!.map((v) => v.toJson()).toList();
    }
    if (taskType != null) {
      data['task_type'] = taskType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
