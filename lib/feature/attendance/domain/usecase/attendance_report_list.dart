import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../attendance.dart';

class AttendanceReportList
    extends UseCaseWithParams<AttendanceReportModel, AttendanceReportParams> {
  const AttendanceReportList(this._repository);

  final AttendanceRepository _repository;

  @override
  ResultFuture<AttendanceReportModel> call(
      AttendanceReportParams params) async {
    return _repository.getAttendanceReportList(params.fromDate, params.toDate);
  }
}

class AttendanceReportParams extends Equatable {
  final String fromDate;
  final String toDate;

  const AttendanceReportParams({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
