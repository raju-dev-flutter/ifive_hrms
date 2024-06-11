import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchRepositoryImpl implements MisspunchRepository {
  const MisspunchRepositoryImpl(this._datasource);

  final MisspunchDataSource _datasource;

  @override
  ResultFuture<MisspunchListModel> getMisspunchRequestList() async {
    try {
      final misspunchResponse = await _datasource.getMisspunchRequestList();

      return Right(misspunchResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MisspunchMessageModel> misspunchRequestSave(DataMap body) async {
    try {
      final response = await _datasource.misspunchRequestSave(body);

      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MisspunchForwardListModel> getMisspunchForwardToList() async {
    try {
      final misspunchForwardResponse =
          await _datasource.getMisspunchForwardToList();

      return Right(misspunchForwardResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MisspunchHistoryModel> getMisspunchHistory(
      String fromDate, String toDate) async {
    try {
      final misspunchResponse =
          await _datasource.getMisspunchHistory(fromDate, toDate);

      return Right(misspunchResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid misspunchCancel(DataMap body) async {
    try {
      final misspunchResponse = await _datasource.misspunchCancel(body);

      return Right(misspunchResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MisspunchApprovedModel> misspunchApproved(
      String fromDate, String toDate) async {
    try {
      final misspunchResponse =
          await _datasource.misspunchApproved(fromDate, toDate);

      return Right(misspunchResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid misspunchUpdate(DataMap body) async {
    try {
      final misspunchResponse = await _datasource.misspunchUpdate(body);

      return Right(misspunchResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
