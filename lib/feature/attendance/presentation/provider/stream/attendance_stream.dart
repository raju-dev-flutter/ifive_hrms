import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../food/food.dart';
import '../../../attendance.dart';

class AttendanceStream {
  AttendanceStream({required GPRSCheckerUseCase $GPRSCheckerUseCase})
      : _$GPRSCheckerUseCase = $GPRSCheckerUseCase;

  final GPRSCheckerUseCase _$GPRSCheckerUseCase;

  final methodChannel = const MethodChannel(AppKeys.methodChannel);

  final descriptionController = TextEditingController();

  final _gprsLocationScanning = BehaviorSubject<bool>.seeded(false);

  final _battery = BehaviorSubject<int>();
  final _capturedImage = BehaviorSubject<XFile?>();
  final _capturedImageLoading = BehaviorSubject<bool>.seeded(false);
  final _capturedUnitListImage = BehaviorSubject<Uint8List>();

  final _latitude = BehaviorSubject<double>();
  final _longitude = BehaviorSubject<double>();
  final _geoAddress = BehaviorSubject<String?>.seeded(null);

  Stream<bool> get gprsLocationScanning => _gprsLocationScanning;

  ValueStream<XFile?> get capturedImage => _capturedImage;

  ValueStream<bool> get capturedImageLoading => _capturedImageLoading;

  ValueStream<Uint8List> get capturedUnitListImage => _capturedUnitListImage;

  ValueStream<String?> get geoAddress => _geoAddress;

  Future<void> fetchInitialCallBack(BuildContext context) async {
    _gprsLocationScanning.sink.add(true);
    final gprsResponse = await _$GPRSCheckerUseCase();
    gprsResponse.fold(
      (__) => {
        Navigator.pop(context),
        AppAlerts.displaySnackBar(
            context, 'Network Error' /*__.message*/, false)
      },
      (_) => fetchCurrentLocation(_, context),
    );
    getBattery();
  }

  Future<void> fetchCurrentLocation(
      GPRSResponseModel gPRSResponse, BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    double endLatitude = double.parse(gPRSResponse.latitude ?? '0');
    double endLongitude = double.parse(gPRSResponse.longitude ?? '0');

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      fetchCurrentLocation(gPRSResponse, context);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> place =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    _latitude.sink.add(position.latitude);
    _longitude.sink.add(position.longitude);
    _geoAddress.sink.add(
        '${place[0].street}, ${place[0].thoroughfare}, ${place[0].subLocality}, ${place[0].locality}, ${place[0].administrativeArea}, ${place[0].postalCode}.');
    if (gPRSResponse.enableGpsRestriction == "Yes") {
      {
        Logger().i("Office Location: $endLatitude, $endLongitude");
        var companyDistance =
            int.parse(SharedPrefs.instance.getString(AppKeys.meter) ?? '0');
        var currentDistance = CalculateDistance().distanceMeter(
            position.latitude, position.longitude, endLatitude, endLongitude);
        Logger().i(
            "Calculated Location:${position.latitude},${position.longitude}, $endLatitude, $endLongitude, $companyDistance, $currentDistance");
        if (currentDistance.toInt() < companyDistance) {
          Logger().i("within 5 meter" "within 5 meter");
          _gprsLocationScanning.sink.add(false);
        } else {
          AppAlerts.displayFencingAlert(
            context: context,
            onPressed: () => {Navigator.pop(context), Navigator.pop(context)},
          );
        }
      }
    } else {
      _gprsLocationScanning.sink.add(false);
    }
  }

  Future<void> getCurrentLocation() async {
    _geoAddress.sink.add(null);
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      getCurrentLocation();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> place =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    _latitude.sink.add(position.latitude);
    _longitude.sink.add(position.longitude);
    _geoAddress.sink.add(
        '${place[0].street}, ${place[0].thoroughfare}, ${place[0].subLocality}, ${place[0].locality}, ${place[0].administrativeArea}, ${place[0].postalCode}.');
  }

  Future<void> startService() async {
    try {
      await methodChannel.invokeMethod("run", <String, dynamic>{
        "token": SharedPrefs().getToken(),
      });
    } catch (e) {
      Logger().e("Error while accessing native call");
    }
  }

  Future<void> getBattery() async {
    try {
      var battery =
          await methodChannel.invokeMethod("battery", <String, dynamic>{});
      _battery.sink.add(battery);
      Logger().i("Mobile Battery: $battery");
      return battery;
    } catch (e) {
      Logger().e("Error while accessing native call");
      _battery.sink.add(0);
    }
  }

  Future<void> stopService() async {
    try {
      await methodChannel.invokeMethod("stop", <String, dynamic>{});
    } catch (e) {
      Logger().e("Error while accessing native call");
    }
  }

  void captureImageLoading() {
    _capturedImageLoading.sink.add(true);
    _capturedImage.sink.add(null);
  }

  void captureImage(XFile photo) async {
    // final ImagePicker picker = ImagePicker();
    // final XFile? photo = await picker.pickImage(
    //     source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    // if (photo == null) {}

    final data = await ImageWatermark.convert(photo);

    _capturedImage.sink.add(data);
    _capturedImageLoading.sink.add(false);
  }

  Future<void> onSubmitCheckIn(BuildContext context) async {
    Logger().i("Started Check IN");

    final DataMap body = {
      'battery': _battery.valueOrNull ?? 0,
      'timestamp': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      'file_path': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      'file_upload': _capturedImage.valueOrNull == null
          ? ''
          : base64
              .encode(File(_capturedImage.valueOrNull!.path).readAsBytesSync()),
      'geo_location': {
        'latitude': _latitude.valueOrNull ?? 0.0,
        'longitude': _longitude.valueOrNull ?? 0.0,
        'geo_address': _geoAddress.valueOrNull ?? '',
      }
    };
    BlocProvider.of<AttendanceBloc>(context).add(WorkStartLocationEvent(
      body: body,
      // battery: (0).toString(),
      // // battery: (_battery.valueOrNull ?? 0).toString(),
      // filePath: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      // fileUpload: null,
      // // : _capturedImage.valueOrNull,
      // latitude: 0.0,
      // longitude: 0.0,
      // geoAddress: '',
      // latitude: _latitude.valueOrNull ?? 0.0,
      // longitude: _longitude.valueOrNull ?? 0.0,
      // geoAddress: _geoAddress.valueOrNull ?? '',
    ));
    startService();
  }

  Future<void> onSubmitCheckOut(BuildContext context) async {
    BlocProvider.of<AttendanceBloc>(context).add(WorkEndLocationEvent(
      battery: _battery.valueOrNull ?? 0,
      mobileTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      timestamp: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      taskDescription: descriptionController.text,
      type: 4,
      latitude: _latitude.valueOrNull ?? 0.0,
      longitude: _longitude.valueOrNull ?? 0.0,
      geoAddress: _geoAddress.valueOrNull ?? '',
    ));
    stopService();
  }

  Future<void> onSubmitFood(BuildContext context, String status) async {
    BlocProvider.of<FoodAttendanceBloc>(context)
        .add(UpdateFoodAttendanceEvent(status: status));
  }
}
