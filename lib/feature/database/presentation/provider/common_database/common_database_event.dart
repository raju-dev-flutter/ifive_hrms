part of 'common_database_bloc.dart';

sealed class CommonDatabaseEvent extends Equatable {
  const CommonDatabaseEvent();

  @override
  List<Object> get props => [];
}

class FetchCommonDatabase extends CommonDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const FetchCommonDatabase(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}

class RefreshFetchCommonDatabase extends CommonDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const RefreshFetchCommonDatabase(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
