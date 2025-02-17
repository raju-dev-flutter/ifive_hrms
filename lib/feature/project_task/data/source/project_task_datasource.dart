import 'dart:io';

import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class ProjectTaskDataSource {
  Future<TaskDataModel> fetchTask(DataMap header, int page, int parPage);

  Future<TaskDeptBasedModel> taskDeptLead(String taskId);

  Future<void> taskUpdate(DataMap body, List<File> file);

  Future<void> taskSave(DataMap body, List<File> file);
}
