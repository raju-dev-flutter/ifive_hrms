import '../../../../core/core.dart';
import '../../misspunch.dart';

class GetMisspunchForwardList
    extends UseCaseWithoutParams<MisspunchForwardListModel> {
  const GetMisspunchForwardList(this._repository);

  final MisspunchRepository _repository;

  @override
  ResultFuture<MisspunchForwardListModel> call() async {
    return _repository.getMisspunchForwardToList();
  }
}
