import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat.dart';

part 'chat_contact_state.dart';

class ChatContactCubit extends Cubit<ChatContactState> {
  ChatContactCubit({required ChatContactUseCase chatContactUseCase})
      : _chatContactUseCase = chatContactUseCase,
        super(initiateState());

  static initiateState() => ChatContactInitial();

  final ChatContactUseCase _chatContactUseCase;

  void fetchChatContact() async {
    emit(ChatContactLoading());
    final response = await _chatContactUseCase.call();
    response.fold(
      (_) => emit(ChatContactFailure(message: _.message)),
      (_) => emit(ChatContactLoaded(chatContactModel: _)),
    );
  }
}
