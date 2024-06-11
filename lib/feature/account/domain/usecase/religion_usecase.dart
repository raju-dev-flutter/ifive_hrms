import '../../../../core/core.dart';
import '../../account.dart';

class ReligionUseCase extends UseCaseWithoutParams<ReligionModel> {
  const ReligionUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<ReligionModel> call() async {
    return _repository.religion();
  }
}
