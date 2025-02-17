import '../../../../core/core.dart';

class TaskDeptBasedModel {
  TaskDetails? taskDetails;
  TaskDepartment? taskDepartment;
  List<CommonList>? taskDepartmentLead;
  List<CommonList>? taskAssignedTo;
  List<CommonList>? taskAdmin;
  List<CommonList>? taskCreatedBy;
  List<CommonList>? taskStatus;

  TaskDeptBasedModel(
      {this.taskDetails,
      this.taskDepartment,
      this.taskDepartmentLead,
      this.taskAssignedTo,
      this.taskAdmin,
      this.taskCreatedBy,
      this.taskStatus});

  TaskDeptBasedModel.fromJson(Map<String, dynamic> json) {
    taskDetails = json['task_details'] != null
        ? TaskDetails.fromJson(json['task_details'])
        : null;
    taskDepartment = json['task_department'] != null
        ? TaskDepartment.fromJson(json['task_department'])
        : null;
    if (json['task_department_lead'] != null) {
      taskDepartmentLead = <CommonList>[];
      json['task_department_lead'].forEach((v) {
        taskDepartmentLead!.add(CommonList.fromJson(v));
      });
    }
    if (json['task_assigned_to'] != null) {
      taskAssignedTo = <CommonList>[];
      json['task_assigned_to'].forEach((v) {
        taskAssignedTo!.add(CommonList.fromJson(v));
      });
    }
    if (json['task_admin'] != null) {
      taskAdmin = <CommonList>[];
      json['task_admin'].forEach((v) {
        taskAdmin!.add(CommonList.fromJson(v));
      });
    }
    if (json['task_created_by'] != null) {
      taskCreatedBy = <CommonList>[];
      json['task_created_by'].forEach((v) {
        taskCreatedBy!.add(CommonList.fromJson(v));
      });
    }
    if (json['task_status'] != null) {
      taskStatus = <CommonList>[];
      json['task_status'].forEach((v) {
        taskStatus!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskDetails != null) {
      data['task_details'] = taskDetails!.toJson();
    }
    if (taskDepartment != null) {
      data['task_department'] = taskDepartment!.toJson();
    }
    if (taskDepartmentLead != null) {
      data['task_department_lead'] =
          taskDepartmentLead!.map((v) => v.toJson()).toList();
    }
    if (taskAssignedTo != null) {
      data['task_assigned_to'] =
          taskAssignedTo!.map((v) => v.toJson()).toList();
    }
    if (taskAdmin != null) {
      data['task_admin'] = taskAdmin!.map((v) => v.toJson()).toList();
    }
    if (taskCreatedBy != null) {
      data['task_created_by'] = taskCreatedBy!.map((v) => v.toJson()).toList();
    }
    if (taskStatus != null) {
      data['task_status'] = taskStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskDetails {
  int? taskmanagerId;
  int? department;
  int? assignedTo;
  String? startDate;
  String? endDate;
  int? departmentLead;
  String? status;
  String? task;
  int? admin;
  String? description;
  int? locationId;
  int? companyId;
  int? organizationId;
  int? createdBy;
  int? lastUpdatedBy;
  String? createdAt;
  String? updatedAt;
  String? billCopy;
  String? billCopy1;
  String? completedAt;
  String? actionRequired;
  int? responsibility;
  int? approver;
  int? referenceId;
  int? projectId;
  String? targetDateToCompletion;
  String? actualDateOfCompletion;
  String? source;

  TaskDetails(
      {this.taskmanagerId,
      this.department,
      this.assignedTo,
      this.startDate,
      this.endDate,
      this.departmentLead,
      this.status,
      this.task,
      this.admin,
      this.description,
      this.locationId,
      this.companyId,
      this.organizationId,
      this.createdBy,
      this.lastUpdatedBy,
      this.createdAt,
      this.updatedAt,
      this.billCopy,
      this.billCopy1,
      this.completedAt,
      this.actionRequired,
      this.responsibility,
      this.approver,
      this.referenceId,
      this.projectId,
      this.targetDateToCompletion,
      this.actualDateOfCompletion,
      this.source});

  TaskDetails.fromJson(Map<String, dynamic> json) {
    taskmanagerId = json['taskmanager_id'];
    department = json['department'];
    assignedTo = json['assigned_to'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    departmentLead = json['department_lead'];
    status = json['status'];
    task = json['task'];
    admin = json['admin'];
    description = json['description'];
    locationId = json['location_id'];
    companyId = json['company_id'];
    organizationId = json['organization_id'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    billCopy = json['bill_copy'];
    billCopy1 = json['bill_copy1'];
    completedAt = json['completed_at'];
    actionRequired = json['action_required'];
    responsibility = json['responsibility'];
    approver = json['approver'];
    referenceId = json['reference_id'];
    projectId = json['project_id'];
    targetDateToCompletion = json['target_date_to_completion'];
    actualDateOfCompletion = json['actual_date_of_completion'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskmanager_id'] = taskmanagerId;
    data['department'] = department;
    data['assigned_to'] = assignedTo;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['department_lead'] = departmentLead;
    data['status'] = status;
    data['task'] = task;
    data['admin'] = admin;
    data['description'] = description;
    data['location_id'] = locationId;
    data['company_id'] = companyId;
    data['organization_id'] = organizationId;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bill_copy'] = billCopy;
    data['bill_copy1'] = billCopy1;
    data['completed_at'] = completedAt;
    data['action_required'] = actionRequired;
    data['responsibility'] = responsibility;
    data['approver'] = approver;
    data['reference_id'] = referenceId;
    data['project_id'] = projectId;
    data['target_date_to_completion'] = targetDateToCompletion;
    data['actual_date_of_completion'] = actualDateOfCompletion;
    data['source'] = source;
    return data;
  }
}

class TaskDepartment {
  int? departmentId;
  String? departmentName;

  TaskDepartment({this.departmentId, this.departmentName});

  TaskDepartment.fromJson(Map<String, dynamic> json) {
    departmentId = json['department_id'];
    departmentName = json['department_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['department_id'] = departmentId;
    data['department_name'] = departmentName;
    return data;
  }
}
