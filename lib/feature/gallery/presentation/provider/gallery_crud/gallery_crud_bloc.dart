import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gallery_crud_event.dart';
part 'gallery_crud_state.dart';

class GalleryCrudBloc extends Bloc<GalleryCrudEvent, GalleryCrudState> {
  GalleryCrudBloc() : super(GalleryCrudInitial()) {
    on<GalleryCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
