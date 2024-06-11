import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../od_permission.dart';

class PermissionCancel extends UseCaseWithParams<void, PermissionCancelParams> {
  const PermissionCancel(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultVoid call(PermissionCancelParams params) async {
    return _repository.permissionCancel(params.body);
  }
}

class PermissionCancelParams extends Equatable {
  final DataMap body;

  const PermissionCancelParams({required this.body});

  const PermissionCancelParams.empty() : this(body: const <String, dynamic>{});

  @override
  List<Object?> get props => [body];
}
