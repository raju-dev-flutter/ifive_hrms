import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchApprovedUseCase
    extends UseCaseWithParams<MisspunchApprovedModel, MisspunchApprovedParams> {
  const MisspunchApprovedUseCase(this._repository);

  final MisspunchRepository _repository;

  @override
  ResultFuture<MisspunchApprovedModel> call(MisspunchApprovedParams params) {
    return _repository.misspunchApproved(params.fromDate, params.toDate);
  }
}

class MisspunchApprovedParams extends Equatable {
  final String fromDate;
  final String toDate;

  const MisspunchApprovedParams({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
