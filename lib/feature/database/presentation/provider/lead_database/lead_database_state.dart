part of 'lead_database_bloc.dart';

sealed class LeadDatabaseState extends Equatable {
  const LeadDatabaseState();

  @override
  List<Object> get props => [];
}

final class LeadDatabaseInitial extends LeadDatabaseState {}

class LeadDatabaseLoading extends LeadDatabaseState {}

class LeadDatabaseLoaded extends LeadDatabaseState {
  final List<DatabaseData> database;
  final bool hasReachedMax;

  const LeadDatabaseLoaded(
      {required this.database, required this.hasReachedMax});

  @override
  List<Object> get props => [database, hasReachedMax];

  LeadDatabaseLoaded copyWith(
      {List<DatabaseData>? database, bool? hasReachedMax}) {
    return LeadDatabaseLoaded(
      database: database ?? this.database,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class LeadDatabaseFailed extends LeadDatabaseState {
  final String message;

  const LeadDatabaseFailed(this.message);

  @override
  List<Object> get props => [message];
}
