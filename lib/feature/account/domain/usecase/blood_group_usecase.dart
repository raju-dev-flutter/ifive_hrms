import '../../../../core/core.dart';
import '../../account.dart';

class BloodGroupUseCase extends UseCaseWithoutParams<BloodGroupModel> {
  const BloodGroupUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<BloodGroupModel> call() async {
    return _repository.bloodGroup();
  }
}
