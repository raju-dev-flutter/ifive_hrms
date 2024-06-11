part of 'new_call_database_bloc.dart';

sealed class NewCallDatabaseState extends Equatable {
  const NewCallDatabaseState();

  @override
  List<Object> get props => [];
}

final class NewCallDatabaseInitial extends NewCallDatabaseState {}

class NewCallDatabaseLoading extends NewCallDatabaseState {}

class NewCallDatabaseLoaded extends NewCallDatabaseState {
  final List<DatabaseData> database;
  final bool hasReachedMax;

  const NewCallDatabaseLoaded(
      {required this.database, required this.hasReachedMax});

  @override
  List<Object> get props => [database, hasReachedMax];

  NewCallDatabaseLoaded copyWith({
    List<DatabaseData>? ticket,
    bool? hasReachedMax,
  }) {
    return NewCallDatabaseLoaded(
      database: database ?? this.database,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class NewCallDatabaseFailed extends NewCallDatabaseState {
  final String message;

  const NewCallDatabaseFailed(this.message);

  @override
  List<Object> get props => [message];
}
