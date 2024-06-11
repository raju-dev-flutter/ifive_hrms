import '../../../../core/core.dart';
import '../../account.dart';

class StateUseCase extends UseCaseWithParams<StateModel, String> {
  const StateUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<StateModel> call(String params) async {
    return _repository.state(params);
  }
}
