part of 'gallery_crud_bloc.dart';

sealed class GalleryCrudState extends Equatable {
  const GalleryCrudState();

  @override
  List<Object> get props => [];
}

final class GalleryCrudInitial extends GalleryCrudState {}

final class GalleryCrudLoading extends GalleryCrudState {}

final class GalleryCrudSuccess extends GalleryCrudState {}

final class GalleryCrudFailure extends GalleryCrudState {
  final String message;

  const GalleryCrudFailure(this.message);

  @override
  List<Object> get props => [message];
}
