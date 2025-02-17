import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

part 'backup_crud_event.dart';
part 'backup_crud_state.dart';

class BackupCrudBloc extends Bloc<BackupCrudEvent, BackupCrudState> {
  BackupCrudBloc() : super(BackupCrudInitial()) {
    on<BackupCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
