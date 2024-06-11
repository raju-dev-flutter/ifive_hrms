import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../appreciation.dart';

class AppreciationRequest
    extends UseCaseWithParams<void, AppreciationRequestParams> {
  const AppreciationRequest(this._repository);

  final AppreciationRepository _repository;
  @override
  ResultVoid call(AppreciationRequestParams params) async {
    return _repository.appreciationRequest(params.body);
  }
}

class AppreciationRequestParams extends Equatable {
  final DataMap body;

  const AppreciationRequestParams({required this.body});

  @override
  // TODO: implement props
  List<Object?> get props => [body];
}
