import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifive_hrms/feature/feature.dart';

import '../../../../../core/core.dart';
import '../../../chat.dart';

part 'chat_crud_event.dart';
part 'chat_crud_state.dart';

class ChatCrudBloc extends Bloc<ChatCrudEvent, ChatCrudState> {
  ChatCrudBloc({required SaveMessageUseCase saveMessageUseCase})
      : _saveMessageUseCase = saveMessageUseCase,
        super(initiateState()) {
    on<SaveMessageEvent>(saveMessageEvent);
  }

  final SaveMessageUseCase _saveMessageUseCase;

  static initiateState() => const ChatCrudInitial();

  void saveMessageEvent(
      SaveMessageEvent event, Emitter<ChatCrudState> emit) async {
    emit(const ChatCrudLoading());
    final response =
        await _saveMessageUseCase(SaveMessageParams(body: event.body));
    response.fold(
      (_) => emit(ChatCrudFailure(message: _.message)),
      (_) => emit(const ChatCrudSuccess()),
    );
  }
}
