part of 'common_project_task_bloc.dart';

sealed class CommonProjectTaskEvent extends Equatable {
  const CommonProjectTaskEvent();

  @override
  List<Object> get props => [];
}

class FetchCommonProjectTask extends CommonProjectTaskEvent {
  final String search;
  final String type;
  final String? date;
  final int page;
  final int perPage;

  const FetchCommonProjectTask(
      {required this.search,
      required this.type,
      this.date,
      required this.page,
      required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}

class RefreshFetchCommonProjectTask extends CommonProjectTaskEvent {
  final String search;
  final String type;
  final String? date;
  final int page;
  final int perPage;

  const RefreshFetchCommonProjectTask(
      {required this.search,
      required this.type,
      this.date,
      required this.page,
      required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
