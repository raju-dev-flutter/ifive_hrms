part of 'dcr_database_bloc.dart';

sealed class DcrDatabaseEvent extends Equatable {
  const DcrDatabaseEvent();

  @override
  List<Object> get props => [];
}

class FetchDcr extends DcrDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const FetchDcr(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}

class RefreshFetchDcr extends DcrDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const RefreshFetchDcr(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
