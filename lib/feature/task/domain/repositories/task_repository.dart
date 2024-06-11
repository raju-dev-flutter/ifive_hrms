import '../../../../core/core.dart';
import '../../../feature.dart';

abstract interface class TaskRepository {
  ResultFuture<TaskPlannerModel> todayTask(String date);

  ResultFuture<TaskPlannerModel> statusBasedTask(String status, String search);

  ResultVoid supportTask(DataMap body);

  ResultFuture<TaskReportModel> taskReport();

  ResultVoid initiatedTaskUpdate(DataMap body);

  ResultVoid pendingTaskUpdate(DataMap body);

  ResultVoid inProgressTaskUpdate(DataMap body);

  ResultVoid testL1TaskUpdate(DataMap body);

  ResultVoid testL2TaskUpdate(DataMap body);

  ResultFuture<EmployeeModel> employeeList();

  ResultFuture<DevTeamModel> teamList();

  ResultFuture<ProjectModel> projectList();
}
