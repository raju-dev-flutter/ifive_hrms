import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class ExperienceUseCase extends UseCaseWithParams<void, ExperienceParams> {
  const ExperienceUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(ExperienceParams params) async {
    return _repository.experienceSave(params.body, params.file);
  }
}

class ExperienceParams extends Equatable {
  final DataMap body;
  final File? file;

  const ExperienceParams({required this.body, required this.file});

  @override
  List<Object?> get props => [body];
}
