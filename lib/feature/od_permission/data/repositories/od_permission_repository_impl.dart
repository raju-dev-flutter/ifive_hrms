import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class ODPermissionRepositoryImpl implements ODPermissionRepository {
  const ODPermissionRepositoryImpl(this._datasource);

  final ODPermissionDataSource _datasource;

  @override
  ResultFuture<PermissionResponseModel> permissionHistory() async {
    try {
      final permissionResponse = await _datasource.permissionHistory();
      return Right(permissionResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid permissionRequest(DataMap body) async {
    try {
      final permissionResponse = await _datasource.permissionRequest(body);
      return Right(permissionResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ODBalanceModel> odBalance(int type) async {
    try {
      final response = await _datasource.odBalance(type);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<PermissionRequestModel> requestTo() async {
    try {
      final response = await _datasource.requestTo();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ShiftTimeResponseModel> shiftTime() async {
    try {
      final response = await _datasource.shiftTime();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid permissionSubmit(DataMap body) async {
    try {
      final response = await _datasource.permissionSubmit(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid permissionUpdate(DataMap body) async {
    try {
      final response = await _datasource.permissionUpdate(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<PermissionHistoryModel> permissionApproval() async {
    try {
      final permissionResponse = await _datasource.permissionApproval();
      return Right(permissionResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid permissionCancel(DataMap body) async {
    try {
      final response = await _datasource.permissionCancel(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
