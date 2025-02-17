part of 'chat_crud_bloc.dart';

sealed class ChatCrudState extends Equatable {
  const ChatCrudState();

  @override
  List<Object> get props => [];
}

final class ChatCrudInitial extends ChatCrudState {
  const ChatCrudInitial();
}

class ChatCrudLoading extends ChatCrudState {
  const ChatCrudLoading();
}

class ChatCrudSuccess extends ChatCrudState {
  const ChatCrudSuccess();
}

class ChatCrudFailure extends ChatCrudState {
  final String message;

  const ChatCrudFailure({required this.message});

  @override
  List<Object> get props => [];
}
