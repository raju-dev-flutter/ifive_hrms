part of 'backup_crud_bloc.dart';

sealed class BackupCrudEvent extends Equatable {
  const BackupCrudEvent();

  @override
  List<Object> get props => [];
}

class BackupSaveEvent extends BackupCrudEvent {
  final DataMap body;

  const BackupSaveEvent({required this.body});

  @override
  List<Object> get props => [body];
}
