import 'dart:io';

import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class ProjectTaskRepository {
  ResultFuture<TaskDataModel> fetchTask(DataMap header, int page, int parPage);

  ResultFuture<TaskDeptBasedModel> taskDeptLead(String taskId);

  ResultVoid taskUpdate(DataMap body, List<File> file);

  ResultVoid taskSave(DataMap body, List<File> file);
}
