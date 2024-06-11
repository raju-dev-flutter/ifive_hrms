import '../../../../core/core.dart';
import '../../account.dart';

class MotherTongueUseCase extends UseCaseWithoutParams<MotherTongueModel> {
  const MotherTongueUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<MotherTongueModel> call() async {
    return _repository.motherTongue();
  }
}
