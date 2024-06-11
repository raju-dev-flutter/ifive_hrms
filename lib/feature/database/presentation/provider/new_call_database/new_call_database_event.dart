part of 'new_call_database_bloc.dart';

sealed class NewCallDatabaseEvent extends Equatable {
  const NewCallDatabaseEvent();

  @override
  List<Object> get props => [];
}

class FetchNewCall extends NewCallDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const FetchNewCall(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}

class RefreshFetchNewCall extends NewCallDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const RefreshFetchNewCall(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
