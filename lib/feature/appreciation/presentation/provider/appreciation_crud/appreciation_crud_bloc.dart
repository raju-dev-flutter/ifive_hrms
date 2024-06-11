import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../appreciation.dart';

part 'appreciation_crud_event.dart';
part 'appreciation_crud_state.dart';

class AppreciationCrudBloc
    extends Bloc<AppreciationCrudEvent, AppreciationCrudState> {
  AppreciationCrudBloc({required AppreciationRequest appreciationRequest})
      : _appreciationRequest = appreciationRequest,
        super(initialState()) {
    on<CreateAppreciationEvent>(_createAppreciationEvent);
  }

  static initialState() => const AppreciationCrudInitial();

  final AppreciationRequest _appreciationRequest;

  void _createAppreciationEvent(CreateAppreciationEvent event,
      Emitter<AppreciationCrudState> emit) async {
    emit(const AppreciationCrudLoading());
    final response =
        await _appreciationRequest(AppreciationRequestParams(body: event.body));
    response.fold(
      (_) => emit(AppreciationCrudFailed(message: _.message)),
      (__) => emit(const AppreciationCrudSuccess()),
    );
  }
}
