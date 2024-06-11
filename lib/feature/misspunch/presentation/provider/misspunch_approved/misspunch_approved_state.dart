part of 'misspunch_approved_cubit.dart';

abstract class MisspunchApprovedState extends Equatable {
  const MisspunchApprovedState();

  @override
  List<Object> get props => [];
}

class MisspunchApprovedInitial extends MisspunchApprovedState {
  const MisspunchApprovedInitial();
}

class MisspunchApprovedLoading extends MisspunchApprovedState {
  const MisspunchApprovedLoading();
}

class MisspunchApprovedLoaded extends MisspunchApprovedState {
  final MisspunchApprovedModel misspunch;

  const MisspunchApprovedLoaded({required this.misspunch});

  @override
  List<Object> get props => [misspunch];
}

class MisspunchApprovedFailed extends MisspunchApprovedState {
  final String message;

  const MisspunchApprovedFailed({required this.message});

  @override
  List<Object> get props => [];
}
