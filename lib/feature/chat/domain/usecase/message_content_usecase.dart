import '../../../../core/core.dart';
import '../../chat.dart';

class MessageContentUseCase
    extends UseCaseWithParams<MessageContentModel, int> {
  const MessageContentUseCase(this._repository);

  final ChatRepository _repository;

  @override
  ResultFuture<MessageContentModel> call(int params) async {
    return _repository.fetchMessageContent(params);
  }
}
