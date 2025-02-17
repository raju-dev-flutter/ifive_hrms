import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final UpdateWorkStartLocation _workStartLocation;
  final UpdateWorkEndLocation _workEndLocation;

  AttendanceBloc(
      {required UpdateWorkStartLocation workStartLocation,
      required UpdateWorkEndLocation workEndLocation})
      : _workStartLocation = workStartLocation,
        _workEndLocation = workEndLocation,
        super(AttendanceInitial()) {
    on<WorkStartLocationEvent>((event, emit) async {
      emit(const AttendanceLoading());

      final result = await _workStartLocation(
          AttendanceStartRequestParams(body: event.body));

      result.fold(
        (failure) => emit(AttendanceFailed(failure.errorMessage)),
        (response) => emit(AttendanceSuccess(message: response.message ?? '')),
      );
    });

    on<WorkEndLocationEvent>((event, emit) async {
      emit(const AttendanceLoading());

      final result = await _workEndLocation(AttendanceEndRequestParams(
        battery: event.battery,
        mobileTime: event.mobileTime,
        timestamp: event.timestamp,
        taskDescription: event.taskDescription,
        type: event.type,
        latitude: event.latitude,
        longitude: event.longitude,
        geoAddress: event.geoAddress,
      ));

      result.fold(
        (failure) => emit(AttendanceFailed(failure.errorMessage)),
        (response) => emit(AttendanceSuccess(message: response.message ?? '')),
      );
    });
  }
}
