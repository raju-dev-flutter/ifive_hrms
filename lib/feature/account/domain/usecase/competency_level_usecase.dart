import '../../../../core/core.dart';
import '../../account.dart';

class CompetencyLevelUseCase
    extends UseCaseWithoutParams<CompetencyLevelModel> {
  const CompetencyLevelUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<CompetencyLevelModel> call() async {
    return _repository.competencyLevel();
  }
}
