import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'sfa_crud_event.dart';
part 'sfa_crud_state.dart';

class SfaCrudBloc extends Bloc<SfaCrudEvent, SfaCrudState> {
  SfaCrudBloc({
    required GenerateTicketUseCase generateTicketUseCase,
    required UploadDatabaseCameraUseCase uploadDatabaseCameraUseCase,
  })  : _generateTicketUseCase = generateTicketUseCase,
        _uploadDatabaseCameraUseCase = uploadDatabaseCameraUseCase,
        super(initialState()) {
    on<GenerateTicketEvent>(_generateTicketEvent);
    on<DatabaseCameraEvent>(_databaseCameraEvent);
  }

  final GenerateTicketUseCase _generateTicketUseCase;
  final UploadDatabaseCameraUseCase _uploadDatabaseCameraUseCase;

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

  _databaseCameraEvent(
      DatabaseCameraEvent event, Emitter<SfaCrudState> emit) async {
    emit(const SfaCrudLoading());
    final response =
        await _uploadDatabaseCameraUseCase(DatabaseCameraParams(event.body));
    response.fold(
      (_) => emit(SfaCrudFailed(message: _.message)),
      (_) => emit(const SfaCrudSuccess()),
    );
  }
}
