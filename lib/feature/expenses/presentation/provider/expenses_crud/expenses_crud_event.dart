part of 'expenses_crud_bloc.dart';

sealed class ExpensesCrudEvent extends Equatable {
  const ExpensesCrudEvent();

  @override
  List<Object> get props => [];
}

class ExpensesSaveEvent extends ExpensesCrudEvent {
  final DataMap body;

  const ExpensesSaveEvent({required this.body});

  @override
  List<Object> get props => [body];
}
