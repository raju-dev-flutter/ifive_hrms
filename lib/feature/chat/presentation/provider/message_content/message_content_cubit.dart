import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat.dart';

part 'message_content_state.dart';

class MessageContentCubit extends Cubit<MessageContentState> {
  MessageContentCubit({required MessageContentUseCase messageContentUseCase})
      : _messageContentUseCase = messageContentUseCase,
        super(initiateState());

  static initiateState() => MessageContentInitial();

  final MessageContentUseCase _messageContentUseCase;

  void refreshMessageContent(int receiverId) async {
    if (state is MessageContentInitial) {
      emit(MessageContentLoading());
      final response = await _messageContentUseCase(receiverId);
      response.fold(
        (_) => emit(MessageContentFailure(_.message)),
        (_) => emit(MessageContentLoaded(message: _)),
      );
    } else if (state is MessageContentLoaded) {
      final response = await _messageContentUseCase(receiverId);
      response.fold(
        (_) => emit(MessageContentFailure(_.message)),
        (_) => emit(MessageContentLoaded(message: _)),
      );
    }
  }

  void fetchMessageContent(int receiverId) async {
    emit(MessageContentLoading());
    final response = await _messageContentUseCase(receiverId);
    response.fold(
      (_) => emit(MessageContentFailure(_.message)),
      (_) => emit(MessageContentLoaded(message: _)),
    );
  }
}
