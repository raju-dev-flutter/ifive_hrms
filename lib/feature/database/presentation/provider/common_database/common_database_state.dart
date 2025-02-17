part of 'common_database_bloc.dart';

sealed class CommonDatabaseState extends Equatable {
  const CommonDatabaseState();

  @override
  List<Object> get props => [];
}

final class CommonDatabaseInitial extends CommonDatabaseState {}

class CommonDatabaseLoading extends CommonDatabaseState {}

class CommonDatabaseLoaded extends CommonDatabaseState {
  final List<DatabaseData> database;
  final bool hasReachedMax;

  const CommonDatabaseLoaded(
      {required this.database, required this.hasReachedMax});

  @override
  List<Object> get props => [database, hasReachedMax];

  CommonDatabaseLoaded copyWith({
    List<DatabaseData>? ticket,
    bool? hasReachedMax,
  }) {
    return CommonDatabaseLoaded(
      database: database ?? this.database,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class CommonDatabaseFailed extends CommonDatabaseState {
  final String message;

  const CommonDatabaseFailed(this.message);

  @override
  List<Object> get props => [message];
}
