part of 'dcr_database_bloc.dart';

sealed class DcrDatabaseState extends Equatable {
  const DcrDatabaseState();

  @override
  List<Object> get props => [];
}

final class DcrDatabaseInitial extends DcrDatabaseState {}

class DcrDatabaseLoading extends DcrDatabaseState {}

class DcrDatabaseLoaded extends DcrDatabaseState {
  final List<DatabaseData> database;
  final bool hasReachedMax;

  const DcrDatabaseLoaded(
      {required this.database, required this.hasReachedMax});

  @override
  List<Object> get props => [database, hasReachedMax];

  DcrDatabaseLoaded copyWith(
      {List<DatabaseData>? database, bool? hasReachedMax}) {
    return DcrDatabaseLoaded(
      database: database ?? this.database,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class DcrDatabaseFailed extends DcrDatabaseState {
  final String message;

  const DcrDatabaseFailed(this.message);

  @override
  List<Object> get props => [message];
}
