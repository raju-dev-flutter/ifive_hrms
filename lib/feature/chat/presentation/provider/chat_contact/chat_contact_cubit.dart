import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_contact_state.dart';

class ChatContactCubit extends Cubit<ChatContactState> {
  ChatContactCubit() : super(ChatContactInitial());
}
