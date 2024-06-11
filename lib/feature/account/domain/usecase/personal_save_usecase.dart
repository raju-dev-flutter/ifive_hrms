import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class PersonalSaveUseCase extends UseCaseWithParams<void, PersonalParams> {
  const PersonalSaveUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(PersonalParams params) async {
    return _repository.personalSave(params.body);
  }
}

class PersonalParams extends Equatable {
  final DataMap body;

  const PersonalParams({required this.body});

  @override
  List<Object?> get props => [body];
}
