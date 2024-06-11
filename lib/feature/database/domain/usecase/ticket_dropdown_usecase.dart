import '../../../../core/core.dart';
import '../../../feature.dart';

class TicketDropdownUseCase extends UseCaseWithoutParams<TicketDropdownModel> {
  const TicketDropdownUseCase(this._repository);

  final SfaRepository _repository;

  @override
  ResultFuture<TicketDropdownModel> call() async {
    return _repository.getTicketDropdown();
  }
}
