part of 'misspunch_history_cubit.dart';

abstract class MisspunchHistoryState extends Equatable {
  const MisspunchHistoryState();

  @override
  List<Object> get props => [];
}

class MisspunchHistoryInitial extends MisspunchHistoryState {
  const MisspunchHistoryInitial();
}

class MisspunchHistoryLoading extends MisspunchHistoryState {
  const MisspunchHistoryLoading();
}

class MisspunchHistoryLoaded extends MisspunchHistoryState {
  final MisspunchHistoryModel misspunch;

  const MisspunchHistoryLoaded({required this.misspunch});

  @override
  List<Object> get props => [misspunch];
}

class MisspunchHistoryFailed extends MisspunchHistoryState {
  final String message;

  const MisspunchHistoryFailed({required this.message});

  @override
  List<Object> get props => [];
}
