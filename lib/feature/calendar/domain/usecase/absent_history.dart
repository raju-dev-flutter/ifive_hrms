import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

class AbsentHistoryUseCase
    extends UseCaseWithParams<AbsentHistoryModel, AbsentRequestParams> {
  const AbsentHistoryUseCase(this._repository);

  final CalendarRepository _repository;

  @override
  ResultFuture<AbsentHistoryModel> call(AbsentRequestParams params) async {
    return _repository.absentHistory(params.fromDate, params.toDate);
  }
}

class AbsentRequestParams extends Equatable {
  final String fromDate;
  final String toDate;

  const AbsentRequestParams({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
