import '../../../../core/core.dart';
import '../../account.dart';

class CertificateLevelUseCase
    extends UseCaseWithoutParams<CertificateLevelModel> {
  const CertificateLevelUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<CertificateLevelModel> call() async {
    return _repository.certificateLevel();
  }
}
