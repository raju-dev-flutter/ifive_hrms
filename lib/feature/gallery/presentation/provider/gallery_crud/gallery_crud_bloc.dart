import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gallery_crud_event.dart';
part 'gallery_crud_state.dart';

class GalleryCrudBloc extends Bloc<GalleryCrudEvent, GalleryCrudState> {
  GalleryCrudBloc() : super(GalleryCrudInitial()) {
    on<GalleryCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
