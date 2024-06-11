import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'sfa_crud_event.dart';
part 'sfa_crud_state.dart';

class SfaCrudBloc extends Bloc<SfaCrudEvent, SfaCrudState> {
  SfaCrudBloc({required GenerateTicketUseCase generateTicketUseCase})
      : _generateTicketUseCase = generateTicketUseCase,
        super(initialState()) {
    on<GenerateTicketEvent>(_generateTicketEvent);
  }

  final GenerateTicketUseCase _generateTicketUseCase;

  static initialState() => const SfaCrudInitial();

  _generateTicketEvent(
      GenerateTicketEvent event, Emitter<SfaCrudState> emit) async {
    emit(const SfaCrudLoading());
    final response = await _generateTicketUseCase(
        GenerateTicketParams(event.body, event.type));
    response.fold(
      (_) => emit(SfaCrudFailed(message: _.message)),
      (_) => emit(const SfaCrudSuccess()),
    );
  }
}
