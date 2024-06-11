import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveUpdate extends UseCaseWithParams<void, LeaveUpdateRequestParams> {
  const LeaveUpdate(this._repository);

  final LeaveRepository _repository;

  @override
  ResultVoid call(LeaveUpdateRequestParams params) async {
    return _repository.leaveUpdate(params.body);
  }
}

class LeaveUpdateRequestParams extends Equatable {
  final DataMap body;

  const LeaveUpdateRequestParams({required this.body});

  const LeaveUpdateRequestParams.empty()
      : this(body: const <String, dynamic>{});

  @override
  List<Object?> get props => [body];
}
