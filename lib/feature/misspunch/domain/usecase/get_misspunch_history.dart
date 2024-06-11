import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../misspunch.dart';

class GetMisspunchHistory
    extends UseCaseWithParams<MisspunchHistoryModel, MisspunchHistoryParams> {
  const GetMisspunchHistory(this._repository);

  final MisspunchRepository _repository;

  @override
  ResultFuture<MisspunchHistoryModel> call(MisspunchHistoryParams params) {
    return _repository.getMisspunchHistory(params.fromDate, params.toDate);
  }
}

class MisspunchHistoryParams extends Equatable {
  final String fromDate;
  final String toDate;

  const MisspunchHistoryParams({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
