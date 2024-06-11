part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class WorkStartLocationEvent extends AttendanceEvent {
  final DataMap body;
  // final String battery;
  // final String filePath;
  // final XFile? fileUpload;
  // final double longitude;
  // final double latitude;
  // final String geoAddress;
/*
 'battery': _battery.valueOrNull ?? 0,
 'timestamp': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
 'file_path': DateFormat("yyyyMMdd_HH_mm_ss").format(DateTime.now()),
 'file_upload': _capturedImage.valueOrNull == null
          ? ""
          : base64
              .encode(File(_capturedImage.valueOrNull!.path).readAsBytesSync()),
 'geo_location': {
 'latitude': _latitude.valueOrNull ?? '',
 'longitude': _longitude.valueOrNull ?? '',
  'geo_address': _geoAddress.valueOrNull ?? '',
      }
 */
  const WorkStartLocationEvent({
    required this.body,
    // required this.battery,
    // required this.filePath,
    // required this.fileUpload,
    // required this.latitude,
    // required this.longitude,
    // required this.geoAddress,
  });

  @override
  List<Object> get props => [body];
  // [battery, filePath, fileUpload!, latitude, longitude, geoAddress];
}

class WorkEndLocationEvent extends AttendanceEvent {
  final int battery;
  final String mobileTime;
  final String timestamp;
  final String taskDescription;
  final int type;
  final double latitude;
  final double longitude;
  final String geoAddress;

  const WorkEndLocationEvent({
    required this.battery,
    required this.mobileTime,
    required this.timestamp,
    required this.taskDescription,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.geoAddress,
  });

  @override
  List<Object> get props => [
        battery,
        mobileTime,
        timestamp,
        taskDescription,
        type,
        latitude,
        longitude,
        geoAddress
      ];
}
