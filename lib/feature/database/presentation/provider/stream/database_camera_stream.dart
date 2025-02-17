import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../database.dart';

class DatabaseCameraStream {
  final _latitude = BehaviorSubject<double>();
  final _longitude = BehaviorSubject<double>();
  final _geoAddress = BehaviorSubject<String?>.seeded(null);

  final _capturedImage = BehaviorSubject<XFile?>();

  final remarksController = TextEditingController();

  final _gprsLocationScanning = BehaviorSubject<bool>.seeded(false);

  ValueStream<XFile?> get capturedImage => _capturedImage;

  ValueStream<bool> get gprsLocationScanning => _gprsLocationScanning;

  ValueStream<String?> get geoAddress => _geoAddress;

  void fetchInitialCallBack(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _capturedImage.sink.add(pickedFile);
    } else {
      Navigator.pop(context);
    }

    getCurrentLocation();
  }

  void takeImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _capturedImage.sink.add(pickedFile);
    }
  }

  Future<void> getCurrentLocation() async {
    _gprsLocationScanning.sink.add(true);
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

    _gprsLocationScanning.sink.add(false);
  }

  void onSubmit(BuildContext context) {
    final body = {
      "file_upload": _capturedImage.valueOrNull == null
          ? ''
          : base64
              .encode(File(_capturedImage.valueOrNull!.path).readAsBytesSync()),
      'latitude': _latitude.valueOrNull ?? 0.0,
      'longitude': _longitude.valueOrNull ?? 0.0,
      'geo_address': _geoAddress.valueOrNull ?? '',
      "remarks": remarksController.text,
    };

    Logger().d(body);

    BlocProvider.of<SfaCrudBloc>(context).add(DatabaseCameraEvent(body: body));
  }
}
