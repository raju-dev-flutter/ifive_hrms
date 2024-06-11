import '../../../../core/core.dart';
import '../../../feature.dart';

class RenewalTrackerUseCase extends UseCaseWithoutParams<RenewalTrackerModel> {
  const RenewalTrackerUseCase(this._repository);

  final OtherServiceRepository _repository;

  @override
  ResultFuture<RenewalTrackerModel> call() async {
    return _repository.renewalTracker();
  }
}
