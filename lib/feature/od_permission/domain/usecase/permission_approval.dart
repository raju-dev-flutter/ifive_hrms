import '../../../../core/core.dart';
import '../../od_permission.dart';

class PermissionApproval extends UseCaseWithoutParams<PermissionHistoryModel> {
  const PermissionApproval(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultFuture<PermissionHistoryModel> call() async {
    return _repository.permissionApproval();
  }
}
