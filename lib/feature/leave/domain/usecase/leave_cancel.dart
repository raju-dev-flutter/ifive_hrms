import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveCancel extends UseCaseWithParams<void, LeaveCancelRequestParams> {
  const LeaveCancel(this._repository);

  final LeaveRepository _repository;

  @override
  ResultVoid call(LeaveCancelRequestParams params) async {
    return _repository.leaveCancel(params.body);
  }
}

class LeaveCancelRequestParams extends Equatable {
  final DataMap body;

  const LeaveCancelRequestParams({required this.body});

  const LeaveCancelRequestParams.empty()
      : this(body: const <String, dynamic>{});

  @override
  List<Object?> get props => [body];
}
