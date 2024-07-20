import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_content_state.dart';

class MessageContentCubit extends Cubit<MessageContentState> {
  MessageContentCubit() : super(MessageContentInitial());
}
