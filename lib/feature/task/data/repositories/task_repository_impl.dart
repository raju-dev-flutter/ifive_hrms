import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this._datasource);

  final TaskDataSource _datasource;

  @override
  ResultFuture<EmployeeModel> employeeList() async {
    try {
      final response = await _datasource.employeeList();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid inProgressTaskUpdate(DataMap body) async {
    try {
      final response = await _datasource.inProgressTaskUpdate(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid initiatedTaskUpdate(DataMap body) async {
    try {
      final response = await _datasource.initiatedTaskUpdate(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid pendingTaskUpdate(DataMap body) async {
    try {
      final response = await _datasource.pendingTaskUpdate(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<TaskPlannerModel> statusBasedTask(
      String status, String search) async {
    try {
      final response = await _datasource.statusBasedTask(status, search);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid testL1TaskUpdate(DataMap body) async {
    try {
      final response = await _datasource.testL1TaskUpdate(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid testL2TaskUpdate(DataMap body) async {
    try {
      final response = await _datasource.testL2TaskUpdate(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<TaskPlannerModel> todayTask(String date) async {
    try {
      final response = await _datasource.todayTask(date);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<TaskReportModel> taskReport() async {
    try {
      final response = await _datasource.taskReport();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid supportTask(DataMap body) async {
    try {
      final response = await _datasource.supportTask(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProjectModel> projectList() async {
    try {
      final response = await _datasource.projectList();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<DevTeamModel> teamList() async {
    try {
      final response = await _datasource.teamList();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
