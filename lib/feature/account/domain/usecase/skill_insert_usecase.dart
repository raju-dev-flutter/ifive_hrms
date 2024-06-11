import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class SkillInsertUseCase extends UseCaseWithParams<void, SkillInsertParams> {
  const SkillInsertUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(SkillInsertParams params) async {
    return _repository.skillInsert(params.body, params.file);
  }
}

class SkillInsertParams extends Equatable {
  final DataMap body;
  final File? file;

  const SkillInsertParams({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}
