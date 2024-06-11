import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchRequestSave
    extends UseCaseWithParams<MisspunchMessageModel, MisspunchRequestParams> {
  const MisspunchRequestSave(this._repository);

  final MisspunchRepository _repository;

  @override
  ResultFuture<MisspunchMessageModel> call(MisspunchRequestParams params) {
    return _repository.misspunchRequestSave(params.body);
  }
}

class MisspunchRequestParams extends Equatable {
  final DataMap body;

  const MisspunchRequestParams({required this.body});

  @override
  List<Object?> get props => [body];
}
