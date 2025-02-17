class TaskDataModel {
  List<TaskData>? taskData;
  int? totalPages;
  int? currentPage;
  int? total;

  TaskDataModel({this.taskData, this.totalPages, this.currentPage, this.total});

  TaskDataModel.fromJson(Map<String, dynamic> json) {
    if (json['task_data'] != null) {
      taskData = <TaskData>[];
      json['task_data'].forEach((v) {
        taskData!.add(TaskData.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskData != null) {
      data['task_data'] = taskData!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    data['total'] = total;
    return data;
  }
}

class TaskData {
  String? status;
  int? taskManagerId;
  int? businessPlanLineId;
  String? endDate;
  String? startDate;
  String? task;
  int? createdBy;
  String? firstName;
  String? departmentName;
  String? username;
  String? description;
  String? refFile;
  List<TaskLogData>? taskLogData;

  TaskData(
      {this.status,
      this.taskManagerId,
      this.businessPlanLineId,
      this.endDate,
      this.startDate,
      this.task,
      this.createdBy,
      this.firstName,
      this.departmentName,
      this.description,
      this.username,
      this.refFile,
      this.taskLogData});

  TaskData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    taskManagerId = json['taskmanager_id'];
    businessPlanLineId = json['businessplan_line_id'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    task = json['task'];
    createdBy = json['created_by'];
    firstName = json['first_name'];
    departmentName = json['department_name'];
    username = json['username'];
    refFile = json['ref_file'];
    description = json['description'];

    if (json['log_datas'] != null) {
      taskLogData = <TaskLogData>[];
      json['log_datas'].forEach((v) {
        taskLogData!.add(TaskLogData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['taskmanager_id'] = taskManagerId;
    data['businessplan_line_id'] = businessPlanLineId;
    data['end_date'] = endDate;
    data['start_date'] = startDate;
    data['task'] = task;
    data['created_by'] = createdBy;
    data['first_name'] = firstName;
    data['department_name'] = departmentName;
    data['username'] = username;
    data['ref_file'] = refFile;
    data['description'] = description;
    if (taskLogData != null) {
      data['log_datas'] = taskLogData!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class TaskLogData {
  int? taskId;
  String? completedRemarks;
  String? logStatus;
  String? rejectedRemarks;
  String? approvedRemarks;
  String? fileUpload;
  int? percentage;

  TaskLogData(
      {this.taskId,
      this.completedRemarks,
      this.logStatus,
      this.rejectedRemarks,
      this.approvedRemarks,
      this.fileUpload,
      this.percentage});

  TaskLogData.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    completedRemarks = json['completed_remarks'];
    logStatus = json['log_status'];
    rejectedRemarks = json['rejected_remarks'];
    approvedRemarks = json['approved_remarks'];
    fileUpload = json['file_upload'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['completed_remarks'] = completedRemarks;
    data['log_status'] = logStatus;
    data['rejected_remarks'] = rejectedRemarks;
    data['approved_remarks'] = approvedRemarks;
    data['file_upload'] = fileUpload;
    data['percentage'] = percentage;
    return data;
  }
}
