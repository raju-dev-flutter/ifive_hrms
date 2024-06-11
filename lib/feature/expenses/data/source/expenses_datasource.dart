import '../../../../core/core.dart';
import '../../expenses.dart';

abstract class ExpensesDataSource {
  Future<ExpensesModel> expensesType();

  Future<ExpensesDataModel> statusBasedExpensesData(DataMap header);

  Future<void> expensesSave(DataMap body);
}
