import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature.dart';

part 'lead_database_event.dart';
part 'lead_database_state.dart';

class LeadDatabaseBloc extends Bloc<LeadDatabaseEvent, LeadDatabaseState> {
  LeadDatabaseBloc({required GetTicketUseCase getTicketUseCase})
      : _getTicketUseCase = getTicketUseCase,
        super(initialState()) {
    on<FetchLead>(_fetchFetchLead);
    on<RefreshFetchLead>(_refreshFetchLead);
  }

  static initialState() => LeadDatabaseInitial();

  final GetTicketUseCase _getTicketUseCase;

  void _refreshFetchLead(
      RefreshFetchLead event, Emitter<LeadDatabaseState> emit) async {
    emit(LeadDatabaseLoading());
    final header = {'type': 'lead', 'search': event.search};
    final response = await _getTicketUseCase(
        GetTicketParams(header, event.page, event.perPage));
    response.fold((_) {
      return emit(LeadDatabaseFailed(_.message));
    }, (_) {
      final database = _.databaseModel?.database ?? [];
      return emit(database.length < event.perPage
          ? LeadDatabaseLoaded(database: database, hasReachedMax: true)
          : LeadDatabaseLoaded(
              database: database, hasReachedMax: database.isEmpty));
    });
  }

  void _fetchFetchLead(FetchLead event, Emitter<LeadDatabaseState> emit) async {
    if (state is LeadDatabaseLoaded &&
        (state as LeadDatabaseLoaded).hasReachedMax) {
      return;
    }
    // try {
    final header = {'type': 'lead', 'search': event.search};
    if (state is LeadDatabaseInitial) {
      emit(LeadDatabaseLoading());
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(LeadDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.length < event.perPage
            ? LeadDatabaseLoaded(database: database, hasReachedMax: true)
            : LeadDatabaseLoaded(
                database: database, hasReachedMax: database.isEmpty));
      });
    } else if (state is LeadDatabaseLoaded) {
      final currentState = state as LeadDatabaseLoaded;
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(LeadDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : LeadDatabaseLoaded(
                database: currentState.database + database,
                hasReachedMax: false));
      });
    }
    // } catch (_) {
    //   emit(const LeadDatabaseFailed('Failed to fetch leads'));
    // }
  }
}
