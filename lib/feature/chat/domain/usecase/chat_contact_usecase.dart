import '../../../../core/core.dart';
import '../../chat.dart';

class ChatContactUseCase extends UseCaseWithoutParams<ChatContactModel> {
  const ChatContactUseCase(this._repository);

  final ChatRepository _repository;

  @override
  ResultFuture<ChatContactModel> call() async {
    return _repository.fetchChatContact();
  }
}
