import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
      Logger().i("Started Bloc");
      // XFile? capturedImage = null;
      //
      // if (event.fileUpload != null) {
      //   capturedImage = await ImageWatermark.convert(event.fileUpload!);
      // }
      //
      // final capturedImage = event.fileUpload == null
      //     ? ""
      //     : base64.encode(File(event.fileUpload!.path).readAsBytesSync());
      //
      // final DataMap body = {
      //   'battery': event.battery,
      //   'timestamp': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      //   'file_path': event.filePath,
      //   'file_upload': capturedImage,
      //   'geo_location': {
      //     'latitude': event.latitude,
      //     'longitude': event.longitude,
      //     'geo_address': event.geoAddress,
      //   }
      // };

      final result = await _workStartLocation(
          AttendanceStartRequestParams(body: event.body));

      result.fold(
        (failure) => emit(AttendanceFailed(failure.errorMessage)),
        (response) => emit(AttendanceSuccess(message: response.message ?? '')),
      );
    });

    on<WorkEndLocationEvent>((event, emit) async {
      emit(const AttendanceLoading());

      Logger().i(
          "Battery: ${event.battery}  mobileTime: ${event.mobileTime}  Timestamp: ${event.timestamp} Description:: ${event.taskDescription}");

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
