part of 'renewal_tracker_cubit.dart';

abstract class RenewalTrackerState extends Equatable {
  const RenewalTrackerState();

  @override
  List<Object> get props => [];
}

class RenewalTrackerInitial extends RenewalTrackerState {
  const RenewalTrackerInitial();
}

class RenewalTrackerLoading extends RenewalTrackerState {
  const RenewalTrackerLoading();
}

class RenewalTrackerLoaded extends RenewalTrackerState {
  final RenewalTrackerModel renewalTracker;

  const RenewalTrackerLoaded(this.renewalTracker);

  @override
  List<Object> get props => [renewalTracker];
}

class RenewalTrackerFailure extends RenewalTrackerState {
  final String message;

  const RenewalTrackerFailure(this.message);

  @override
  List<Object> get props => [message];
}
