part of 'gallery_crud_bloc.dart';

sealed class GalleryCrudState extends Equatable {
  const GalleryCrudState();
}

final class GalleryCrudInitial extends GalleryCrudState {
  @override
  List<Object> get props => [];
}
