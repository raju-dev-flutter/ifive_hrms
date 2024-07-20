part of 'chat_crud_bloc.dart';

sealed class ChatCrudState extends Equatable {
  const ChatCrudState();
}

final class ChatCrudInitial extends ChatCrudState {
  @override
  List<Object> get props => [];
}
