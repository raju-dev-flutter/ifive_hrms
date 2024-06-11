import '../../../../core/core.dart';
import '../../dashboard.dart';

class AppMenuUseCase extends UseCaseWithoutParams<AppMenuModel> {
  const AppMenuUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<AppMenuModel> call() async {
    return _repository.appMenu();
  }
}
