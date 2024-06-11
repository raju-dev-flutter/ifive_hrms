part of 'lead_database_bloc.dart';

sealed class LeadDatabaseEvent extends Equatable {
  const LeadDatabaseEvent();

  @override
  List<Object> get props => [];
}

class FetchLead extends LeadDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const FetchLead(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}

class RefreshFetchLead extends LeadDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const RefreshFetchLead(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
