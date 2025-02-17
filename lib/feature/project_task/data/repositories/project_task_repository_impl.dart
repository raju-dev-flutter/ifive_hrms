import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../project_task.dart';

class ProjectTaskRepositoryImpl implements ProjectTaskRepository {
  const ProjectTaskRepositoryImpl(this._datasource);

  final ProjectTaskDataSource _datasource;

  @override
  ResultFuture<TaskDataModel> fetchTask(
      DataMap header, int page, int parPage) async {
    try {
      final response = await _datasource.fetchTask(header, page, parPage);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<TaskDeptBasedModel> taskDeptLead(String taskId) async {
    try {
      final response = await _datasource.taskDeptLead(taskId);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid taskUpdate(DataMap body, List<File> file) async {
    try {
      final response = await _datasource.taskUpdate(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid taskSave(DataMap body, List<File> file) async {
    try {
      final response = await _datasource.taskSave(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
