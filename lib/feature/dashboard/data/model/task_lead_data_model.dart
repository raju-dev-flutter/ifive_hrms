class TaskLeadDataModel {
  List<TaskLeadData>? taskLeadData;

  TaskLeadDataModel({this.taskLeadData});

  TaskLeadDataModel.fromJson(Map<String, dynamic> json) {
    if (json['task_lead_data'] != null) {
      taskLeadData = <TaskLeadData>[];
      json['task_lead_data'].forEach((v) {
        taskLeadData!.add(new TaskLeadData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskLeadData != null) {
      data['task_lead_data'] = taskLeadData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskLeadData {
  int? taskPlannerId;
  String? task;
  String? taskDate;
  String? targetDate;
  String? status;
  String? discuss;
  String? projectName;
  String? taskGivenByName;
  String? assignToName;

  TaskLeadData(
      {this.taskPlannerId,
      this.task,
      this.taskDate,
      this.targetDate,
      this.status,
      this.discuss,
      this.projectName,
      this.taskGivenByName,
      this.assignToName});

  TaskLeadData.fromJson(Map<String, dynamic> json) {
    taskPlannerId = json['taskplanner_id'];
    task = json['task'];
    taskDate = json['task_date'];
    targetDate = json['target_date'];
    status = json['status'];
    discuss = json['discuss'];
    projectName = json['project_name'];
    taskGivenByName = json['task_given_by_name'];
    assignToName = json['assign_to_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskplanner_id'] = taskPlannerId;
    data['task'] = task;
    data['task_date'] = taskDate;
    data['target_date'] = targetDate;
    data['status'] = status;
    data['discuss'] = discuss;
    data['project_name'] = projectName;
    data['task_given_by_name'] = taskGivenByName;
    data['assign_to_name'] = assignToName;
    return data;
  }
}
