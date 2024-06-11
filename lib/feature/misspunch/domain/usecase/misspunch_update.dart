import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchUpdate extends UseCaseWithParams<void, MisspunchUpdateParams> {
  const MisspunchUpdate(this._repository);

  final MisspunchRepository _repository;

  @override
  ResultVoid call(MisspunchUpdateParams params) {
    return _repository.misspunchUpdate(params.body);
  }
}

class MisspunchUpdateParams extends Equatable {
  final DataMap body;

  const MisspunchUpdateParams({required this.body});

  @override
  List<Object?> get props => [body];
}
