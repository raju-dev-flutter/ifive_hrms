import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../leave.dart';


class LeaveMode extends UseCaseWithParams<LeaveModeModel, LeaveModeParams> {
  const LeaveMode(this._repository);

  final LeaveRepository _repository;

  @override
  ResultFuture<LeaveModeModel> call(LeaveModeParams params) async {
    return _repository.leaveMode(params.type);
  }
}

class LeaveModeParams extends Equatable {
  final int type;

  const LeaveModeParams({required this.type});

  const LeaveModeParams.empty() : this(type: 0);

  @override
  List<Object?> get props => [type];
}
