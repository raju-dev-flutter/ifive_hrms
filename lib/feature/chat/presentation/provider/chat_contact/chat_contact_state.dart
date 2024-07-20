part of 'chat_contact_cubit.dart';

sealed class ChatContactState extends Equatable {
  const ChatContactState();
}

final class ChatContactInitial extends ChatContactState {
  @override
  List<Object> get props => [];
}
