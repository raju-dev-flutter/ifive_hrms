import '../../../../core/core.dart';
import '../../account.dart';

class ProfileDetail extends UseCaseWithoutParams<ProfileDetailModel> {
  const ProfileDetail(this._repository);

  final AccountRepository _repository;

  @override
  ResultFuture<ProfileDetailModel> call() async {
    return _repository.profileDetail();
  }
}
