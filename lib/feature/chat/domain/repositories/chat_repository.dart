import '../../../../core/core.dart';
import '../../chat.dart';

abstract class ChatRepository {
  ResultFuture<ChatContactModel> fetchChatContact();

  ResultFuture<MessageContentModel> fetchMessageContent(int receiverId);

  ResultVoid saveMessage(DataMap body);
}
