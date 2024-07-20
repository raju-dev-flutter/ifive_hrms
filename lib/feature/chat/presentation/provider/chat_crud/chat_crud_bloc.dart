import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_crud_event.dart';
part 'chat_crud_state.dart';

class ChatCrudBloc extends Bloc<ChatCrudEvent, ChatCrudState> {
  ChatCrudBloc() : super(ChatCrudInitial()) {
    on<ChatCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
