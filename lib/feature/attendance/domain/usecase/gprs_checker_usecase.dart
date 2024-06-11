import '../../../../core/core.dart';
import '../../attendance.dart';

class GPRSCheckerUseCase extends UseCaseWithoutParams<GPRSResponseModel> {
  const GPRSCheckerUseCase(this._repository);

  final AttendanceRepository _repository;

  @override
  ResultFuture<GPRSResponseModel> call() async {
    return _repository.gprsChecker();
  }
}
