part of 'message_content_cubit.dart';

sealed class MessageContentState extends Equatable {
  const MessageContentState();
}

final class MessageContentInitial extends MessageContentState {
  @override
  List<Object> get props => [];
}
