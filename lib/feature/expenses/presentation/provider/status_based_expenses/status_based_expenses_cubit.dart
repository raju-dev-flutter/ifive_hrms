import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature.dart';

part 'status_based_expenses_state.dart';

class StatusBasedExpensesCubit extends Cubit<StatusBasedExpensesState> {
  StatusBasedExpensesCubit(
      {required StatusBasedExpensesDataUseCase statusBasedExpensesDataUseCase})
      : _statusBasedExpensesDataUseCase = statusBasedExpensesDataUseCase,
        super(initialState());

  static initialState() => StatusBasedExpensesInitial();

  final StatusBasedExpensesDataUseCase _statusBasedExpensesDataUseCase;

  void getStatusBasedExpensesData(
      {required String status,
      required String from,
      required String to}) async {
    emit(StatusBasedExpensesLoading());
    final response = await _statusBasedExpensesDataUseCase(
        StatusBasedParams(body: {'status': status, 'from': from, 'to': to}));
    response.fold(
      (_) => emit(StatusBasedExpensesFailure(message: _.message)),
      (_) => emit(StatusBasedExpensesLoaded(expenses: _.expensesData ?? [])),
    );
  }
}
