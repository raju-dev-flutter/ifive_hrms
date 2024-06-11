import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class VisaImmigrationUseCase
    extends UseCaseWithParams<void, VisaImmigrationParams> {
  const VisaImmigrationUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(VisaImmigrationParams params) async {
    return _repository.visaAndImmigrationSave(params.body, params.file);
  }
}

class VisaImmigrationParams extends Equatable {
  final DataMap body;
  final File? file;

  const VisaImmigrationParams({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}
