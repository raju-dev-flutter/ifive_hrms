import '../../../../core/core.dart';
import '../../../feature.dart';

class RenewalTrackerUseCase
    extends UseCaseWithParams<RenewalTrackerModel, String> {
  const RenewalTrackerUseCase(this._repository);

  final OtherServiceRepository _repository;

  @override
  ResultFuture<RenewalTrackerModel> call(String params) async {
    return _repository.renewalTracker(params);
  }
}
