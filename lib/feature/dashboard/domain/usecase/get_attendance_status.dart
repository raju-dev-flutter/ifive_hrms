import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../attendance/attendance.dart';
import '../../dashboard.dart';

class GetAttendanceStatus
    extends UseCaseWithParams<AttendanceResponse, AttendanceStatusParams> {
  const GetAttendanceStatus(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<AttendanceResponse> call(AttendanceStatusParams params) async {
    return _repository.getAttendanceStatus(params.token);
  }
}

class AttendanceStatusParams extends Equatable {
  final String token;

  const AttendanceStatusParams({required this.token});

  const AttendanceStatusParams.empty() : this(token: '_empty.token');

  @override
  List<Object> get props => [token];
}
