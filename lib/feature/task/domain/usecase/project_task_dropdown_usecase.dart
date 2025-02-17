import '../../../../core/core.dart';
import '../../../feature.dart';

class ProjectTaskDropdownUseCase
    extends UseCaseWithoutParams<ProjectTaskDropdownModel> {
  const ProjectTaskDropdownUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<ProjectTaskDropdownModel> call() async {
    return await _repository.projectTaskDropdown();
  }
}
