import '../../../../core/core.dart';
import '../../account.dart';

class NationalityUseCase extends UseCaseWithoutParams<NationalityModel> {
  const NationalityUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<NationalityModel> call() async {
    return _repository.nationality();
  }
}
