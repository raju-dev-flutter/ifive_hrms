part of 'status_based_expenses_cubit.dart';

sealed class StatusBasedExpensesState extends Equatable {
  const StatusBasedExpensesState();

  @override
  List<Object> get props => [];
}

final class StatusBasedExpensesInitial extends StatusBasedExpensesState {}

final class StatusBasedExpensesLoading extends StatusBasedExpensesState {}

final class StatusBasedExpensesLoaded extends StatusBasedExpensesState {
  final List<ExpensesData> expenses;

  const StatusBasedExpensesLoaded({required this.expenses});

  @override
  List<Object> get props => [expenses];
}

final class StatusBasedExpensesFailure extends StatusBasedExpensesState {
  final String message;

  const StatusBasedExpensesFailure({required this.message});

  @override
  List<Object> get props => [message];
}
