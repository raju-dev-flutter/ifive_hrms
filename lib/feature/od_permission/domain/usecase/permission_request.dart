import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../od_permission.dart';

class PermissionSubmit extends UseCaseWithParams<void, PermissionSubmitParams> {
  const PermissionSubmit(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultVoid call(PermissionSubmitParams params) async {
    return _repository.permissionSubmit(params.body);
  }
}

class PermissionSubmitParams extends Equatable {
  final DataMap body;

  const PermissionSubmitParams({required this.body});

  const PermissionSubmitParams.empty() : this(body: const <String, dynamic>{});

  @override
  List<Object?> get props => [body];
}
