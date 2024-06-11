import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class IndustryBasedVerticalDropdownUseCase
    extends UseCaseWithParams<TicketDropdownModel, IndustryParams> {
  const IndustryBasedVerticalDropdownUseCase(this._repository);

  final SfaRepository _repository;

  @override
  ResultFuture<TicketDropdownModel> call(IndustryParams params) async {
    return _repository.industryBasedVerticalDropdown(params.id);
  }
}

class IndustryParams extends Equatable {
  final int id;

  const IndustryParams(this.id);

  @override
  List<Object?> get props => [id];
}
