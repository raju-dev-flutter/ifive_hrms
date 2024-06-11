import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'expenses_crud_event.dart';
part 'expenses_crud_state.dart';

class ExpensesCrudBloc extends Bloc<ExpensesCrudEvent, ExpensesCrudState> {
  ExpensesCrudBloc({required ExpensesSaveUseCase expensesSaveUseCase})
      : _expensesSaveUseCase = expensesSaveUseCase,
        super(initialState()) {
    on<ExpensesSaveEvent>(_expensesSaveEvent);
  }

  static initialState() => ExpensesCrudInitial();

  final ExpensesSaveUseCase _expensesSaveUseCase;

  _expensesSaveEvent(
      ExpensesSaveEvent event, Emitter<ExpensesCrudState> emit) async {
    emit(ExpensesCrudLoading());
    final response =
        await _expensesSaveUseCase(ExpensesSaveParams(body: event.body));
    response.fold(
      (_) => emit(ExpensesCrudFailure(message: _.message)),
      (_) => emit(ExpensesCrudSuccess()),
    );
  }
}
