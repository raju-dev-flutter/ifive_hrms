import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../chat.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._datasource);

  final ChatDataSource _datasource;

  @override
  ResultFuture<ChatContactModel> fetchChatContact() async {
    try {
      final response = await _datasource.fetchChatContact();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MessageContentModel> fetchMessageContent(int receiverId) async {
    try {
      final response = await _datasource.fetchMessageContent(receiverId);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveMessage(DataMap body) async {
    try {
      final response = await _datasource.saveMessage(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
