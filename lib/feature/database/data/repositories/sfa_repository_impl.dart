import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class SfaRepositoryImpl implements SfaRepository {
  const SfaRepositoryImpl(this._datasource);

  final SfaDataSource _datasource;

  @override
  ResultFuture<TicketDropdownModel> getTicketDropdown() async {
    try {
      final response = await _datasource.getTicketDropdown();

      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid uploadGenerateTicket(DataMap body, String type) async {
    try {
      final response = await _datasource.uploadGenerateTicket(body, type);

      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<TicketDropdownModel> industryBasedVerticalDropdown(
      int id) async {
    try {
      final response = await _datasource.industryBasedVerticalDropdown(id);

      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<TicketDropdownModel> verticalBasedSubVerticalDropdown(
      int id) async {
    try {
      final response = await _datasource.verticalBasedSubVerticalDropdown(id);
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<DatabaseDataModel> getTicket(
      DataMapString header, int page, int parPage) async {
    try {
      final response = await _datasource.getTicket(header, page, parPage);
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid uploadDataBaseCamera(DataMap body) async {
    try {
      final response = await _datasource.uploadDataBaseCamera(body);
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }
}
