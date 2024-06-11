import '../../../../core/core.dart';
import '../../od_permission.dart';

class ShiftTimeUseCase extends UseCaseWithoutParams<ShiftTimeResponseModel> {
  const ShiftTimeUseCase(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultFuture<ShiftTimeResponseModel> call() async {
    return _repository.shiftTime();
  }
}
