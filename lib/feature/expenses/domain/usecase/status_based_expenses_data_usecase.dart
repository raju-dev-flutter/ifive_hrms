import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../expenses.dart';

class StatusBasedExpensesDataUseCase
    extends UseCaseWithParams<ExpensesDataModel, StatusBasedParams> {
  StatusBasedExpensesDataUseCase(this._repository);

  final ExpensesRepository _repository;

  @override
  ResultFuture<ExpensesDataModel> call(StatusBasedParams params) async {
    return _repository.statusBasedExpensesData(params.body);
  }
}

class StatusBasedParams extends Equatable {
  final DataMap body;

  const StatusBasedParams({required this.body});

  @override
  List<Object?> get props => [body];
}
