import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class PayrollRepositoryImpl implements PayrollRepository {
  const PayrollRepositoryImpl(this._datasource);

  final PayrollDataSource _datasource;

  @override
  ResultFuture<PaySlipResponseModel> payslip(
      String fromDate, String toDate) async {
    try {
      final response = await _datasource.payslip(fromDate, toDate);

      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<PaySlipModel> payslipDocument(String id) async {
    try {
      final response = await _datasource.payslipDocument(id);

      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }
}
