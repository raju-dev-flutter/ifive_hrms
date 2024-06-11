part of 'pipeline_database_bloc.dart';

sealed class PipelineDatabaseEvent extends Equatable {
  const PipelineDatabaseEvent();

  @override
  List<Object> get props => [];
}

class FetchPipeline extends PipelineDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const FetchPipeline(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}

class RefreshFetchPipeline extends PipelineDatabaseEvent {
  final String search;
  final int page;
  final int perPage;

  const RefreshFetchPipeline(
      {required this.search, required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
