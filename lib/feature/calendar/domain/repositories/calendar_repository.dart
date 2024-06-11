import '../../../../core/core.dart';
import '../../calendar.dart';

abstract class CalendarRepository {
  ResultFuture<HolidayHistoryModel> holidayHistory();

  ResultFuture<LeavesHistoryModel> leavesHistory();

  ResultFuture<PresentHistoryModel> presentHistory(
      String fromDate, String toDate);

  ResultFuture<AbsentHistoryModel> absentHistory(
      String fromDate, String toDate);
}
