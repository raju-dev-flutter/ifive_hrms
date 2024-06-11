import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  const LeaveRepositoryImpl(this._datasource);

  final LeaveDataSource _datasource;

  @override
  ResultFuture<LeaveForwardModel> leaveForward(int type, int noOfDay) async {
    try {
      final leaveForward = await _datasource.leaveForward(type, noOfDay);
      return Right(leaveForward);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LeaveModeModel> leaveMode(int type) async {
    try {
      final leaveMode = await _datasource.leaveMode(type);
      return Right(leaveMode);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<RemainingLeaveModel> leaveRemaining(int type) async {
    try {
      final leaveRemaining = await _datasource.leaveRemaining(type);
      return Right(leaveRemaining);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid leaveRequest(DataMap body) async {
    try {
      final leaveResponse = await _datasource.leaveRequest(body);
      return Right(leaveResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LeaveTypeModel> leaveType() async {
    try {
      final leaveTypeResponse = await _datasource.leaveType();
      return Right(leaveTypeResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LeaveHistoryModel> leaveHistory() async {
    try {
      final leaveHistoryResponse = await _datasource.leaveHistory();
      return Right(leaveHistoryResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LeaveApprovedModel> leaveApproved(
      String fromDate, String toDate) async {
    try {
      final leaveApprovedResponse =
          await _datasource.leaveApproved(fromDate, toDate);
      return Right(leaveApprovedResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid leaveCancel(DataMap body) async {
    try {
      final leaveResponse = await _datasource.leaveCancel(body);
      return Right(leaveResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid leaveUpdate(DataMap body) async {
    try {
      final leaveResponse = await _datasource.leaveUpdate(body);
      return Right(leaveResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LeaveBalanceModel> leaveBalanceCalculate(DataMap body) async {
    try {
      final leaveResponse = await _datasource.leaveBalanceCalculate(body);
      return Right(leaveResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
