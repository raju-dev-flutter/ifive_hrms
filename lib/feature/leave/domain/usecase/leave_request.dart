import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveRequest extends UseCaseWithParams<void, LeaveRequestParams> {
  const LeaveRequest(this._repository);

  final LeaveRepository _repository;

  @override
  ResultVoid call(LeaveRequestParams params) async {
    return _repository.leaveRequest(params.body);
  }
}

class LeaveRequestParams extends Equatable {
  final DataMap body;

  const LeaveRequestParams({required this.body});

  const LeaveRequestParams.empty() : this(body: const <String, dynamic>{});

  @override
  List<Object?> get props => [body];
}
