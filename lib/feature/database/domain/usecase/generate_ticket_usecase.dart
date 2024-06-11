import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class GenerateTicketUseCase
    extends UseCaseWithParams<void, GenerateTicketParams> {
  const GenerateTicketUseCase(this._repository);

  final SfaRepository _repository;

  @override
  ResultVoid call(GenerateTicketParams params) async {
    return _repository.uploadGenerateTicket(params.body, params.type);
  }
}

class GenerateTicketParams extends Equatable {
  final DataMap body;
  final String type;

  const GenerateTicketParams(this.body, this.type);

  @override
  List<Object?> get props => [body, type];
}
