import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class TrainingCertificationUseCase
    extends UseCaseWithParams<void, TrainingCertificationParams> {
  const TrainingCertificationUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(TrainingCertificationParams params) async {
    return _repository.trainingAndCertificationSave(params.body, params.file);
  }
}

class TrainingCertificationParams extends Equatable {
  final DataMap body;
  final File? file;

  const TrainingCertificationParams({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}
