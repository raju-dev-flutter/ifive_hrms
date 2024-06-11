import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchCancel extends UseCaseWithParams<void, MisspunchCancelParams> {
  const MisspunchCancel(this._repository);

  final MisspunchRepository _repository;

  @override
  ResultVoid call(MisspunchCancelParams params) {
    return _repository.misspunchCancel(params.body);
  }
}

class MisspunchCancelParams extends Equatable {
  final DataMap body;

  const MisspunchCancelParams({required this.body});

  @override
  List<Object?> get props => [body];
}
