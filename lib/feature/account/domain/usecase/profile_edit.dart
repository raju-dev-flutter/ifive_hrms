import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class ProfileEdit extends UseCaseWithParams<void, EditRequestParams> {
  const ProfileEdit(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(EditRequestParams params) async {
    return _repository.profileEdit(params.body);
  }
}

class EditRequestParams extends Equatable {
  final DataMap body;

  const EditRequestParams({required this.body});

  @override
  List<Object?> get props => [body];
}
