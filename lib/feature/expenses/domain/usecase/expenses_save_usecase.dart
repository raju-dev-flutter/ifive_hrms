import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../expenses.dart';

class ExpensesSaveUseCase extends UseCaseWithParams<void, ExpensesSaveParams> {
  ExpensesSaveUseCase(this._repository);

  final ExpensesRepository _repository;

  @override
  ResultVoid call(ExpensesSaveParams params) async {
    return _repository.expensesSave(params.body);
  }
}

class ExpensesSaveParams extends Equatable {
  final DataMap body;

  const ExpensesSaveParams({required this.body});

  @override
  List<Object?> get props => [body];
}
