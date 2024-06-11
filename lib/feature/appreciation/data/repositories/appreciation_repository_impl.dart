import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../appreciation.dart';

class AppreciationRepositoryImpl implements AppreciationRepository {
  const AppreciationRepositoryImpl(this._datasource);

  final AppreciationDataSource _datasource;

  @override
  ResultVoid appreciationRequest(DataMap body) async {
    try {
      final response = await _datasource.appreciationRequest(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<EmployeeUserModel> employeeUserList() async {
    try {
      final response = await _datasource.employeeUserList();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
