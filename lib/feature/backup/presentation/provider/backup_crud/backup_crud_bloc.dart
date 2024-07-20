import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'backup_crud_event.dart';
part 'backup_crud_state.dart';

class BackupCrudBloc extends Bloc<BackupCrudEvent, BackupCrudState> {
  BackupCrudBloc() : super(BackupCrudInitial()) {
    on<BackupCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
