import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature.dart';

part 'pipeline_database_event.dart';
part 'pipeline_database_state.dart';

class PipelineDatabaseBloc
    extends Bloc<PipelineDatabaseEvent, PipelineDatabaseState> {
  PipelineDatabaseBloc({required GetTicketUseCase getTicketUseCase})
      : _getTicketUseCase = getTicketUseCase,
        super(initialState()) {
    on<FetchPipeline>(_fetchFetchPipeline);
    on<RefreshFetchPipeline>(_refreshFetchPipeline);
  }

  static initialState() => PipelineDatabaseInitial();

  final GetTicketUseCase _getTicketUseCase;

  void _refreshFetchPipeline(
      RefreshFetchPipeline event, Emitter<PipelineDatabaseState> emit) async {
    emit(PipelineDatabaseLoading());
    final header = {'type': 'pipeline', 'search': event.search};
    final response = await _getTicketUseCase(
        GetTicketParams(header, event.page, event.perPage));
    response.fold((_) {
      return emit(PipelineDatabaseFailed(_.message));
    }, (_) {
      final database = _.databaseModel?.database ?? [];
      return emit(database.length < event.perPage
          ? PipelineDatabaseLoaded(database: database, hasReachedMax: true)
          : PipelineDatabaseLoaded(
              database: database, hasReachedMax: database.isEmpty));
    });
  }

  void _fetchFetchPipeline(
      FetchPipeline event, Emitter<PipelineDatabaseState> emit) async {
    if (state is PipelineDatabaseLoaded &&
        (state as PipelineDatabaseLoaded).hasReachedMax) {
      return;
    }
    // try {
    final header = {'type': 'pipeline', 'search': event.search};
    if (state is PipelineDatabaseInitial) {
      emit(PipelineDatabaseLoading());
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(PipelineDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.length < event.perPage
            ? PipelineDatabaseLoaded(database: database, hasReachedMax: true)
            : PipelineDatabaseLoaded(
                database: database, hasReachedMax: database.isEmpty));
      });
    } else if (state is PipelineDatabaseLoaded) {
      final currentState = state as PipelineDatabaseLoaded;
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(PipelineDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : PipelineDatabaseLoaded(
                database: currentState.database + database,
                hasReachedMax: false));
      });
    }
    // } catch (_) {
    //   emit(const PipelineDatabaseFailed('Failed to fetch leads'));
    // }
  }
}
