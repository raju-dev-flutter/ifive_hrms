import '../../../../core/core.dart';
import '../../task.dart';

abstract interface class TaskDataSource {
  Future<TaskPlannerModel> todayTask(String date);

  Future<TaskPlannerModel> statusBasedTask(String status, String search);

  Future<TaskReportModel> taskReport();

  Future<void> supportTask(DataMap body);

  Future<void> initiatedTaskUpdate(DataMap body);

  Future<void> pendingTaskUpdate(DataMap body);

  Future<void> inProgressTaskUpdate(DataMap body);

  Future<void> testL1TaskUpdate(DataMap body);

  Future<void> testL2TaskUpdate(DataMap body);

  Future<EmployeeModel> employeeList();

  Future<ProjectModel> projectList();

  Future<DevTeamModel> teamList();

  Future<ProjectTaskDropdownModel> projectTaskDropdown();
}
