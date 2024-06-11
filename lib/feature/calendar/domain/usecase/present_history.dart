import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

class PresentHistoryUseCase
    extends UseCaseWithParams<PresentHistoryModel, PresentRequestParams> {
  const PresentHistoryUseCase(this._repository);

  final CalendarRepository _repository;

  @override
  ResultFuture<PresentHistoryModel> call(PresentRequestParams params) async {
    return _repository.presentHistory(params.fromDate, params.toDate);
  }
}

class PresentRequestParams extends Equatable {
  final String fromDate;
  final String toDate;

  const PresentRequestParams({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
