import '../../../../core/core.dart';
import '../../expenses.dart';

class ExpensesTypeUseCase extends UseCaseWithoutParams<ExpensesModel> {
  ExpensesTypeUseCase(this._repository);

  final ExpensesRepository _repository;

  @override
  ResultFuture<ExpensesModel> call() async {
    return _repository.expensesType();
  }
}
