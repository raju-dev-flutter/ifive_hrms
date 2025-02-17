part of 'backup_crud_bloc.dart';

sealed class BackupCrudState extends Equatable {
  const BackupCrudState();

  @override
  List<Object> get props => [];
}

final class BackupCrudInitial extends BackupCrudState {}

final class BackupCrudLoading extends BackupCrudState {}

final class BackupCrudSuccess extends BackupCrudState {}

final class BackupCrudFailure extends BackupCrudState {
  final String message;

  const BackupCrudFailure({required this.message});

  @override
  List<Object> get props => [message];
}
