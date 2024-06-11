import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  const CalendarRepositoryImpl(this._datasource);

  final CalendarDataSource _datasource;

  @override
  ResultFuture<HolidayHistoryModel> holidayHistory() async {
    try {
      final response = await _datasource.holidayHistory();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LeavesHistoryModel> leavesHistory() async {
    try {
      final response = await _datasource.leavesHistory();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<PresentHistoryModel> presentHistory(
      String fromDate, String toDate) async {
    try {
      final response = await _datasource.presentHistory(fromDate, toDate);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AbsentHistoryModel> absentHistory(
      String fromDate, String toDate) async {
    try {
      final response = await _datasource.absentHistory(fromDate, toDate);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
