import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../expenses.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  const ExpensesRepositoryImpl(this._datasource);

  final ExpensesDataSource _datasource;

  @override
  ResultVoid expensesSave(DataMap body) async {
    try {
      final response = await _datasource.expensesSave(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ExpensesModel> expensesType() async {
    try {
      final response = await _datasource.expensesType();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ExpensesDataModel> statusBasedExpensesData(
      DataMap header) async {
    try {
      final response = await _datasource.statusBasedExpensesData(header);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
