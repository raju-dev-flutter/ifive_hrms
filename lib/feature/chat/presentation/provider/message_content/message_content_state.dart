part of 'message_content_cubit.dart';

sealed class MessageContentState extends Equatable {
  const MessageContentState();

  @override
  List<Object> get props => [];
}

final class MessageContentInitial extends MessageContentState {}

class MessageContentLoading extends MessageContentState {}

class MessageContentLoaded extends MessageContentState {
  final MessageContentModel message;

  const MessageContentLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageContentFailure extends MessageContentState {
  final String message;

  const MessageContentFailure(this.message);

  @override
  List<Object> get props => [message];
}
