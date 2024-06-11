part of 'gprs_checker_cubit.dart';

abstract class GPRSCheckerState extends Equatable {
  const GPRSCheckerState();
  @override
  List<Object> get props => [];
}

class GPRSCheckerInitial extends GPRSCheckerState {
  const GPRSCheckerInitial();
}

class GPRSCheckerLoading extends GPRSCheckerState {
  const GPRSCheckerLoading();
}

class GPRSCheckerLoaded extends GPRSCheckerState {
  final GPRSResponseModel gprsResponse;

  const GPRSCheckerLoaded({required this.gprsResponse});

  @override
  List<Object> get props => [gprsResponse];
}

class GPRSCheckerFailed extends GPRSCheckerState {
  final String message;

  const GPRSCheckerFailed({required this.message});

  @override
  List<Object> get props => [message];
}
