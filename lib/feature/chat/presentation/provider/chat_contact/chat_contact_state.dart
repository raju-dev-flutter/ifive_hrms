part of 'chat_contact_cubit.dart';

sealed class ChatContactState extends Equatable {
  const ChatContactState();

  @override
  List<Object> get props => [];
}

final class ChatContactInitial extends ChatContactState {}

final class ChatContactLoading extends ChatContactState {}

final class ChatContactLoaded extends ChatContactState {
  final ChatContactModel chatContactModel;

  const ChatContactLoaded({required this.chatContactModel});

  @override
  List<Object> get props => [chatContactModel];
}

final class ChatContactFailure extends ChatContactState {
  final String message;

  const ChatContactFailure({required this.message});

  @override
  List<Object> get props => [message];
}
