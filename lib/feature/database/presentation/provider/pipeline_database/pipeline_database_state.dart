part of 'pipeline_database_bloc.dart';

sealed class PipelineDatabaseState extends Equatable {
  const PipelineDatabaseState();

  @override
  List<Object> get props => [];
}

final class PipelineDatabaseInitial extends PipelineDatabaseState {}

class PipelineDatabaseLoading extends PipelineDatabaseState {}

class PipelineDatabaseLoaded extends PipelineDatabaseState {
  final List<DatabaseData> database;
  final bool hasReachedMax;

  const PipelineDatabaseLoaded(
      {required this.database, required this.hasReachedMax});

  @override
  List<Object> get props => [database, hasReachedMax];

  PipelineDatabaseLoaded copyWith(
      {List<DatabaseData>? database, bool? hasReachedMax}) {
    return PipelineDatabaseLoaded(
      database: database ?? this.database,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class PipelineDatabaseFailed extends PipelineDatabaseState {
  final String message;

  const PipelineDatabaseFailed(this.message);

  @override
  List<Object> get props => [message];
}
