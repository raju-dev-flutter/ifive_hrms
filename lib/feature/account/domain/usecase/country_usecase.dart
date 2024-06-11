import '../../../../core/core.dart';
import '../../account.dart';

class CountryUseCase extends UseCaseWithoutParams<CountryModel> {
  const CountryUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<CountryModel> call() async {
    return _repository.country();
  }
}
