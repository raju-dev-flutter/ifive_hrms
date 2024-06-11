import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpload extends UseCaseWithParams<void, UploadRequestParams> {
  const ProfileUpload(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(UploadRequestParams params) async {
    return _repository.profileUpload(params.body);
  }
}

class UploadRequestParams extends Equatable {
  final DataMap body;

  const UploadRequestParams({required this.body});

  @override
  List<Object?> get props => [body];
}
