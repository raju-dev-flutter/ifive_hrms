import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../od_permission.dart';

class PermissionUpdate extends UseCaseWithParams<void, PermissionUpdateParams> {
  const PermissionUpdate(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultVoid call(PermissionUpdateParams params) async {
    return _repository.permissionUpdate(params.body);
  }
}

class PermissionUpdateParams extends Equatable {
  final DataMap body;

  const PermissionUpdateParams({required this.body});

  const PermissionUpdateParams.empty() : this(body: const <String, dynamic>{});

  @override
  List<Object?> get props => [body];
}
