import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class GetTicketUseCase
    extends UseCaseWithParams<DatabaseDataModel, GetTicketParams> {
  const GetTicketUseCase(this._repository);

  final SfaRepository _repository;

  @override
  ResultFuture<DatabaseDataModel> call(GetTicketParams params) async {
    return _repository.getTicket(params.header, params.page, params.perPage);
  }
}

class GetTicketParams extends Equatable {
  final DataMapString header;
  final int page;
  final int perPage;

  const GetTicketParams(this.header, this.page, this.perPage);

  @override
  List<Object?> get props => [header, page, perPage];
}
