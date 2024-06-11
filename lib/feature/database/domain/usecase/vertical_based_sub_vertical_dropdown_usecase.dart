import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class VerticalBasedSubVerticalDropdownUseCase
    extends UseCaseWithParams<TicketDropdownModel, VerticalParams> {
  const VerticalBasedSubVerticalDropdownUseCase(this._repository);

  final SfaRepository _repository;

  @override
  ResultFuture<TicketDropdownModel> call(VerticalParams params) async {
    return _repository.verticalBasedSubVerticalDropdown(params.id);
  }
}

class VerticalParams extends Equatable {
  final int id;

  const VerticalParams(this.id);

  @override
  List<Object?> get props => [id];
}
