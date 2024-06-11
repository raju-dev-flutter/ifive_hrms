part of 'appreciation_cubit.dart';

abstract class AppreciationState extends Equatable {
  const AppreciationState();

  @override
  List<Object> get props => [];
}

class AppreciationInitial extends AppreciationState {
  const AppreciationInitial();
}

class AppreciationLoading extends AppreciationState {
  const AppreciationLoading();
}

class AppreciationLoaded extends AppreciationState {
  final AnnouncementResponseModel appreciation;

  const AppreciationLoaded({required this.appreciation});

  @override
  List<Object> get props => [appreciation];
}

class AppreciationFailed extends AppreciationState {
  final String message;

  const AppreciationFailed({required this.message});

  @override
  List<Object> get props => [];
}
