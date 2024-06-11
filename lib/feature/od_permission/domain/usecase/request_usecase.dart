import '../../../../core/core.dart';
import '../../../feature.dart';

class RequestToUseCase extends UseCaseWithoutParams<PermissionRequestModel> {
  const RequestToUseCase(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultFuture<PermissionRequestModel> call() async {
    return _repository.requestTo();
  }
}
