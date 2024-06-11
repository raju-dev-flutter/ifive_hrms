import '../../../../core/core.dart';
import '../../expenses.dart';

abstract class ExpensesRepository {
  ResultFuture<ExpensesModel> expensesType();

  ResultFuture<ExpensesDataModel> statusBasedExpensesData(DataMap header);

  ResultVoid expensesSave(DataMap body);
}
