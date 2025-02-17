import '../../../../core/core.dart';
import '../../chat.dart';

abstract class ChatDataSource {
  Future<ChatContactModel> fetchChatContact();

  Future<MessageContentModel> fetchMessageContent(int receiverId);

  Future<void> saveMessage(DataMap body);
}
