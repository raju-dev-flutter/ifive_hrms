import '../../../../core/core.dart';
import '../../../feature.dart';

class TeamUseCase extends UseCaseWithoutParams<DevTeamModel> {
  const TeamUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<DevTeamModel> call() async {
    return await _repository.teamList();
  }
}
