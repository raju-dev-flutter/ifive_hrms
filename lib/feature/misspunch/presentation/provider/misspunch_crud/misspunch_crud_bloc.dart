import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../misspunch.dart';

part 'misspunch_crud_event.dart';
part 'misspunch_crud_state.dart';

class MisspunchCrudBloc extends Bloc<MisspunchCrudEvent, MisspunchCrudState> {
  MisspunchCrudBloc(
      {required MisspunchRequestSave misspunchRequestSave,
      required MisspunchCancel misspunchCancel,
      required MisspunchUpdate misspunchUpdate})
      : _misspunchRequestSave = misspunchRequestSave,
        _misspunchCancel = misspunchCancel,
        _misspunchUpdate = misspunchUpdate,
        super(initialState()) {
    on<MisspunchRequestSaveEven>(_misspunchRequestSaveEvent);
    on<MisspunchCancelEvent>(_misspunchCancelEvent);
    on<MisspunchUpdateEvent>(_misspunchUpdateEvent);
  }

  static initialState() => const MisspunchCrudInitial();

  final MisspunchRequestSave _misspunchRequestSave;
  final MisspunchCancel _misspunchCancel;
  final MisspunchUpdate _misspunchUpdate;

  void _misspunchRequestSaveEvent(
      MisspunchRequestSaveEven event, Emitter<MisspunchCrudState> emit) async {
    emit(const MisspunchCrudLoading());

    final response = await _misspunchRequestSave(MisspunchRequestParams(
      body: event.body,
    ));

    response.fold(
      (_) => emit(MisspunchCrudFailed(message: _.message)),
      (__) => emit(MisspunchCrudSuccess()),
    );
  }

  void _misspunchCancelEvent(
      MisspunchCancelEvent event, Emitter<MisspunchCrudState> emit) async {
    emit(const MisspunchCrudLoading());

    final response =
        await _misspunchCancel(MisspunchCancelParams(body: event.body));

    response.fold(
      (_) => emit(MisspunchCrudFailed(message: _.message)),
      (__) => emit(const MisspunchCrudSuccess()),
    );
  }

  void _misspunchUpdateEvent(
      MisspunchUpdateEvent event, Emitter<MisspunchCrudState> emit) async {
    emit(const MisspunchCrudLoading());

    final response =
        await _misspunchUpdate(MisspunchUpdateParams(body: event.body));

    response.fold(
      (_) => emit(MisspunchCrudFailed(message: _.message)),
      (__) => emit(const MisspunchCrudSuccess()),
    );
  }
}
