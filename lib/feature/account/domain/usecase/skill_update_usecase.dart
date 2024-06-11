import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class SkillUpdateUseCase extends UseCaseWithParams<void, SkillUpdateParams> {
  const SkillUpdateUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(SkillUpdateParams params) async {
    return _repository.skillUpdate(params.body, params.file);
  }
}

class SkillUpdateParams extends Equatable {
  final DataMap body;
  final File? file;

  const SkillUpdateParams({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}
