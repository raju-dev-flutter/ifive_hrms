import '../../../../core/core.dart';
import '../../calendar.dart';

class HolidayHistoryUseCase extends UseCaseWithoutParams<HolidayHistoryModel> {
  const HolidayHistoryUseCase(this._repository);

  final CalendarRepository _repository;

  @override
  ResultFuture<HolidayHistoryModel> call() async {
    return _repository.holidayHistory();
  }
}
