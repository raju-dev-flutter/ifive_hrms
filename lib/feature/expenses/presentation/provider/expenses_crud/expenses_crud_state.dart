part of 'expenses_crud_bloc.dart';

sealed class ExpensesCrudState extends Equatable {
  const ExpensesCrudState();

  @override
  List<Object> get props => [];
}

final class ExpensesCrudInitial extends ExpensesCrudState {}

final class ExpensesCrudLoading extends ExpensesCrudState {}

final class ExpensesCrudSuccess extends ExpensesCrudState {}

final class ExpensesCrudFailure extends ExpensesCrudState {
  final String message;

  const ExpensesCrudFailure({required this.message});

  @override
  List<Object> get props => [message];
}
