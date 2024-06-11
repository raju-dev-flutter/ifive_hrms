import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature.dart';

part 'dcr_database_event.dart';
part 'dcr_database_state.dart';

class DcrDatabaseBloc extends Bloc<DcrDatabaseEvent, DcrDatabaseState> {
  DcrDatabaseBloc({required GetTicketUseCase getTicketUseCase})
      : _getTicketUseCase = getTicketUseCase,
        super(initialState()) {
    on<FetchDcr>(_fetchFetchDcr);
    on<RefreshFetchDcr>(_refreshFetchDcr);
  }

  static initialState() => DcrDatabaseInitial();

  final GetTicketUseCase _getTicketUseCase;

  void _refreshFetchDcr(
      RefreshFetchDcr event, Emitter<DcrDatabaseState> emit) async {
    emit(DcrDatabaseLoading());
    final header = {'type': 'dcr', 'search': event.search};
    final response = await _getTicketUseCase(
        GetTicketParams(header, event.page, event.perPage));
    response.fold((_) {
      return emit(DcrDatabaseFailed(_.message));
    }, (_) {
      final database = _.databaseModel?.database ?? [];
      return emit(database.length < event.perPage
          ? DcrDatabaseLoaded(database: database, hasReachedMax: true)
          : DcrDatabaseLoaded(
              database: database, hasReachedMax: database.isEmpty));
    });
  }

  void _fetchFetchDcr(FetchDcr event, Emitter<DcrDatabaseState> emit) async {
    if (state is DcrDatabaseLoaded &&
        (state as DcrDatabaseLoaded).hasReachedMax) {
      return;
    }
    // try {
    final header = {'type': 'dcr', 'search': event.search};
    if (state is DcrDatabaseInitial) {
      emit(DcrDatabaseLoading());
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(DcrDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.length < event.perPage
            ? DcrDatabaseLoaded(database: database, hasReachedMax: true)
            : DcrDatabaseLoaded(
                database: database, hasReachedMax: database.isEmpty));
      });
    } else if (state is DcrDatabaseLoaded) {
      final currentState = state as DcrDatabaseLoaded;
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(DcrDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];

        return emit(database.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : DcrDatabaseLoaded(
                database: currentState.database + database,
                hasReachedMax: false));
      });
    }
    // } catch (_) {
    //   emit(const DcrDatabaseFailed('Failed to fetch leads'));
    // }
  }
}
