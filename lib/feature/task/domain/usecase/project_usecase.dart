import '../../../../core/core.dart';
import '../../../feature.dart';

class ProjectUseCase extends UseCaseWithoutParams<ProjectModel> {
  const ProjectUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<ProjectModel> call() async {
    return await _repository.projectList();
  }
}
