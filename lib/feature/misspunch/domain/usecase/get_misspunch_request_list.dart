import '../../../../core/core.dart';
import '../../misspunch.dart';

class GetMisspunchRequestList extends UseCaseWithoutParams<MisspunchListModel> {
  const GetMisspunchRequestList(this._repository);

  final MisspunchRepository _repository;

  @override
  ResultFuture<MisspunchListModel> call() async {
    return _repository.getMisspunchRequestList();
  }
}
