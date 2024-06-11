import '../../../../core/core.dart';
import '../../account.dart';

class EducationLevelUseCase extends UseCaseWithoutParams<EducationLevelModel> {
  const EducationLevelUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<EducationLevelModel> call() async {
    return _repository.educationLevel();
  }
}
