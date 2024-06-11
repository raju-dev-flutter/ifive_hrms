import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifive_hrms/feature/feature.dart';

part 'new_call_database_event.dart';
part 'new_call_database_state.dart';

class NewCallDatabaseBloc
    extends Bloc<NewCallDatabaseEvent, NewCallDatabaseState> {
  NewCallDatabaseBloc({required GetTicketUseCase getTicketUseCase})
      : _getTicketUseCase = getTicketUseCase,
        super(initialState()) {
    on<FetchNewCall>(_fetchNewCall);
    on<RefreshFetchNewCall>(_refreshFetchNewCall);
  }

  static initialState() => NewCallDatabaseInitial();

  final GetTicketUseCase _getTicketUseCase;

  void _refreshFetchNewCall(
      RefreshFetchNewCall event, Emitter<NewCallDatabaseState> emit) async {
    emit(NewCallDatabaseLoading());
    final header = {'type': '', 'search': event.search};
    final response = await _getTicketUseCase(
        GetTicketParams(header, event.page, event.perPage));
    response.fold((_) {
      return emit(NewCallDatabaseFailed(_.message));
    }, (_) {
      final database = _.databaseModel?.database ?? [];
      return emit(database.length < event.perPage
          ? NewCallDatabaseLoaded(database: database, hasReachedMax: true)
          : NewCallDatabaseLoaded(
              database: database, hasReachedMax: database.isEmpty));
    });
  }

  void _fetchNewCall(
      FetchNewCall event, Emitter<NewCallDatabaseState> emit) async {
    if (state is NewCallDatabaseLoaded &&
        (state as NewCallDatabaseLoaded).hasReachedMax) {
      return;
    }
    // try {
    final header = {'type': '', 'search': event.search};
    if (state is NewCallDatabaseInitial) {
      emit(NewCallDatabaseLoading());
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(NewCallDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.length < event.perPage
            ? NewCallDatabaseLoaded(database: database, hasReachedMax: true)
            : NewCallDatabaseLoaded(
                database: database, hasReachedMax: database.isEmpty));
      });
    } else if (state is NewCallDatabaseLoaded) {
      final currentState = state as NewCallDatabaseLoaded;
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(NewCallDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : NewCallDatabaseLoaded(
                database: currentState.database + database,
                hasReachedMax: false));
      });
    }
    // } catch (_) {
    //   emit(const NewCallDatabaseFailed('Failed to fetch leads'));
    // }
  }
}
