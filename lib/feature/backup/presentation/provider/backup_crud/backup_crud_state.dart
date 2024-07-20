part of 'backup_crud_bloc.dart';

sealed class BackupCrudState extends Equatable {
  const BackupCrudState();
}

final class BackupCrudInitial extends BackupCrudState {
  @override
  List<Object> get props => [];
}
