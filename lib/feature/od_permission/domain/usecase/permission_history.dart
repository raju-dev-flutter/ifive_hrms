import '../../../../core/core.dart';
import '../../od_permission.dart';

class PermissionHistory extends UseCaseWithoutParams<PermissionResponseModel> {
  const PermissionHistory(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultFuture<PermissionResponseModel> call() async {
    return _repository.permissionHistory();
  }
}
