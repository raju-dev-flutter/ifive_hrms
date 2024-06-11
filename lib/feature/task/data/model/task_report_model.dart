class TaskReportModel {
  TaskPlannerReport? taskPlannerReport;

  TaskReportModel({this.taskPlannerReport});

  TaskReportModel.fromJson(Map<String, dynamic> json) {
    taskPlannerReport = json['task_planner_report'] != null
        ? TaskPlannerReport.fromJson(json['task_planner_report'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskPlannerReport != null) {
      data['task_planner_report'] = taskPlannerReport!.toJson();
    }
    return data;
  }
}

class TaskPlannerReport {
  String? createdCount;
  String? initiatedCount;
  String? pendingCount;
  String? inProgressCount;
  String? testingL1Count;
  String? testingL2Count;
  String? reworkCount;
  String? holdCount;
  String? completedCount;

  TaskPlannerReport(
      {this.createdCount,
      this.initiatedCount,
      this.pendingCount,
      this.inProgressCount,
      this.testingL1Count,
      this.testingL2Count,
      this.reworkCount,
      this.holdCount,
      this.completedCount});

  TaskPlannerReport.fromJson(Map<String, dynamic> json) {
    createdCount = json['created_count'];
    initiatedCount = json['initiated_count'];
    pendingCount = json['pending_count'];
    inProgressCount = json['in_progress_count'];
    testingL1Count = json['testing_l1_count'];
    testingL2Count = json['testing_l2_count'];
    reworkCount = json['rework_count'];
    holdCount = json['hold_count'];
    completedCount = json['completed_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_count'] = createdCount;
    data['initiated_count'] = initiatedCount;
    data['pending_count'] = pendingCount;
    data['in_progress_count'] = inProgressCount;
    data['testing_l1_count'] = testingL1Count;
    data['testing_l2_count'] = testingL2Count;
    data['rework_count'] = reworkCount;
    data['hold_count'] = holdCount;
    data['completed_count'] = completedCount;
    return data;
  }
}
