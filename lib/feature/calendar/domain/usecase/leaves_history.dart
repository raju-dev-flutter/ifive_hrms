import '../../../../core/core.dart';
import '../../calendar.dart';

class LeavesHistoryUseCase extends UseCaseWithoutParams<LeavesHistoryModel> {
  const LeavesHistoryUseCase(this._repository);

  final CalendarRepository _repository;

  @override
  ResultFuture<LeavesHistoryModel> call() async {
    return _repository.leavesHistory();
  }
}
