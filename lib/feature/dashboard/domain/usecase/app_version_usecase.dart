import '../../../../core/core.dart';
import '../../dashboard.dart';

class AppVersionUseCase extends UseCaseWithoutParams<AppVersionModel> {
  const AppVersionUseCase(this._repository);

  final DashboardRepository _repository;
  @override
  ResultFuture<AppVersionModel> call() {
    return _repository.appVersion();
  }
}
