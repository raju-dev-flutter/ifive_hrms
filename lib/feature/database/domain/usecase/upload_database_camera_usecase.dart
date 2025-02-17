import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class UploadDatabaseCameraUseCase
    extends UseCaseWithParams<void, DatabaseCameraParams> {
  const UploadDatabaseCameraUseCase(this._repository);

  final SfaRepository _repository;

  @override
  ResultVoid call(DatabaseCameraParams params) async {
    return _repository.uploadDataBaseCamera(params.body);
  }
}

class DatabaseCameraParams extends Equatable {
  final DataMap body;

  const DatabaseCameraParams(this.body);

  @override
  List<Object?> get props => [body];
}
