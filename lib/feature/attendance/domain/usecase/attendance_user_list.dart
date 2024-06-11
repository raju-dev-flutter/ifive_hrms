import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../attendance.dart';

class GetAttendanceUserList
    extends UseCaseWithParams<OverAllAttendanceModel, ReportListRequestParams> {
  const GetAttendanceUserList(this._repository);

  final AttendanceRepository _repository;

  @override
  ResultFuture<OverAllAttendanceModel> call(
      ReportListRequestParams params) async {
    return _repository.getAttendanceUserList(params.date, params.id);
  }
}

class ReportListRequestParams extends Equatable {
  final String date;
  final String id;

  const ReportListRequestParams({required this.date, required this.id});

  const ReportListRequestParams.empty()
      : this(date: "_empty.date", id: "_empty.id");

  @override
  List<Object?> get props => [date, id];
}
