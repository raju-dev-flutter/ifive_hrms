import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class ChangePassword extends UseCaseWithParams<void, PasswordParams> {
  const ChangePassword(this._repository);

  final AuthRepository _repository;

  @override
  ResultVoid call(PasswordParams params) async {
    return _repository.changePassword(params.password);
  }
}

class PasswordParams extends Equatable {
  final String password;

  const PasswordParams({required this.password});

  const PasswordParams.empty() : this(password: '_empty.password');

  @override
  List<Object> get props => [password];
}
