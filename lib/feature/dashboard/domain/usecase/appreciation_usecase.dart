import '../../../../core/core.dart';
import '../../dashboard.dart';

class AppreciationUseCase
    extends UseCaseWithoutParams<AnnouncementResponseModel> {
  const AppreciationUseCase(this._repository);

  final DashboardRepository _repository;
  @override
  ResultFuture<AnnouncementResponseModel> call() {
    return _repository.appreciation();
  }
}
