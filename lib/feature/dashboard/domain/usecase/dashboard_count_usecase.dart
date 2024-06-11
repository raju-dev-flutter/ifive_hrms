import 'package:ifive_hrms/core/core.dart';
import 'package:ifive_hrms/feature/dashboard/dashboard.dart';

class DashboardCountUseCase extends UseCaseWithoutParams<DashboardCountModel> {
  const DashboardCountUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<DashboardCountModel> call() {
    return _repository.dashboardCount();
  }
}
