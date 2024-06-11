import '../../../../core/core.dart';
import '../../account.dart';

class CityUseCase extends UseCaseWithParams<CityModel, String> {
  const CityUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<CityModel> call(String params) async {
    return _repository.city(params);
  }
}
