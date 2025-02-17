part of 'chat_crud_bloc.dart';

sealed class ChatCrudEvent extends Equatable {
  const ChatCrudEvent();

  @override
  List<Object> get props => [];
}

class SaveMessageEvent extends ChatCrudEvent {
  final DataMap body;

  const SaveMessageEvent({required this.body});

  @override
  List<Object> get props => [body];
}
