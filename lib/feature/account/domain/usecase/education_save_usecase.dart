import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class EducationUseCase extends UseCaseWithParams<void, EducationParams> {
  const EducationUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(EducationParams params) async {
    return _repository.educationSave(params.body, params.file);
  }
}

class EducationParams extends Equatable {
  final DataMap body;
  final File? file;

  const EducationParams({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}
