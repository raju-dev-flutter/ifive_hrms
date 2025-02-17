import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature.dart';

part 'common_database_event.dart';
part 'common_database_state.dart';

class CommonDatabaseBloc
    extends Bloc<CommonDatabaseEvent, CommonDatabaseState> {
  CommonDatabaseBloc({required GetTicketUseCase getTicketUseCase})
      : _getTicketUseCase = getTicketUseCase,
        super(initialState()) {
    on<FetchCommonDatabase>(_fetchCommonDatabase);
    on<RefreshFetchCommonDatabase>(_refreshFetchCommonDatabase);
  }

  static initialState() => CommonDatabaseInitial();

  final GetTicketUseCase _getTicketUseCase;

  void _refreshFetchCommonDatabase(RefreshFetchCommonDatabase event,
      Emitter<CommonDatabaseState> emit) async {
    emit(CommonDatabaseLoading());
    final header = {'type': 'database', 'search': event.search};
    final response = await _getTicketUseCase(
        GetTicketParams(header, event.page, event.perPage));
    response.fold((_) {
      return emit(CommonDatabaseFailed(_.message));
    }, (_) {
      final database = _.databaseModel?.database ?? [];
      return emit(database.length < event.perPage
          ? CommonDatabaseLoaded(database: database, hasReachedMax: true)
          : CommonDatabaseLoaded(
              database: database, hasReachedMax: database.isEmpty));
    });
  }

  void _fetchCommonDatabase(
      FetchCommonDatabase event, Emitter<CommonDatabaseState> emit) async {
    if (state is CommonDatabaseLoaded &&
        (state as CommonDatabaseLoaded).hasReachedMax) {
      return;
    }
    final header = {'type': 'database', 'search': event.search};
    if (state is CommonDatabaseInitial) {
      emit(CommonDatabaseLoading());
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(CommonDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.length < event.perPage
            ? CommonDatabaseLoaded(database: database, hasReachedMax: true)
            : CommonDatabaseLoaded(
                database: database, hasReachedMax: database.isEmpty));
      });
    } else if (state is CommonDatabaseLoaded) {
      final currentState = state as CommonDatabaseLoaded;
      final response = await _getTicketUseCase(
          GetTicketParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(CommonDatabaseFailed(_.message));
      }, (_) {
        final database = _.databaseModel?.database ?? [];
        return emit(database.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : CommonDatabaseLoaded(
                database: currentState.database + database,
                hasReachedMax: false));
      });
    }
  }
}
