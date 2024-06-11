import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../dashboard/dashboard.dart';
import '../../../attendance.dart';

class AttendanceSlideAction extends StatefulWidget {
  const AttendanceSlideAction({super.key});

  @override
  State<AttendanceSlideAction> createState() => _AttendanceSlideActionState();
}

class _AttendanceSlideActionState extends State<AttendanceSlideAction> {
  String address = '';
  double latitude = 0;
  double longitude = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    setState(() => isLoading = true);

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

    List<Placemark> place = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (mounted) {
      setState(() {
        address =
            '${place[0].street}, ${place[0].thoroughfare}, ${place[0].subLocality}, ${place[0].locality}, ${place[0].administrativeArea}, ${place[0].postalCode}.';
        latitude = position.latitude;
        longitude = position.longitude;
        isCheckYourLocation(position.latitude, position.longitude);
      });
    }
  }

  void isCheckYourLocation(latitude, longitude) {
    String enableGpsRestriction =
        SharedPrefs.instance.getString(AppKeys.enableGpsRestriction) ?? '0';
    Logger().i("Enable Gps Restriction : $enableGpsRestriction");
    if (enableGpsRestriction == 'No' || enableGpsRestriction == '') {
      setState(() => isLoading = false);
    } else {
      Logger().i("Fencing Alert");
      double endLatitude =
          double.parse(SharedPrefs.instance.getString(AppKeys.latitude) ?? '0');
      double endLongitude = double.parse(
          SharedPrefs.instance.getString(AppKeys.longitude) ?? '0');

      Logger().i("Data: $endLatitude, $endLongitude");
      var companyDistance =
          int.parse(SharedPrefs.instance.getString(AppKeys.meter) ?? '0');
      var currentDistance = CalculateDistance()
          .distanceMeter(latitude, longitude, endLatitude, endLongitude);
      Logger().i(
          "Data:$latitude,$longitude, $endLatitude, $endLongitude, $companyDistance , $currentDistance");

      if (currentDistance.toInt() < companyDistance) {
        setState(() => isLoading = false);
        Logger().i("within 5 meter" "within 5 meter");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceStatusCubit, AttendanceStatusState>(
      builder: (context, state) {
        if (state is AttendanceStatusLoading) Container();

        if (state is AttendanceStatusLoaded) {
          if (checkAttendance(state.attendanceResponse) == "Check In") {
            return Container();
          } else {
            return isLoading
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionSlider.standard(
                      sliderBehavior: SliderBehavior.stretch,
                      rolling: true,
                      width: 300.0,
                      height: 42,
                      backgroundColor: Colors.white,
                      toggleColor: appColor.brand900,
                      iconAlignment: Alignment.centerRight,
                      boxShadow: [
                        BoxShadow(
                          color: appColor.gray50.withOpacity(.3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      loadingIcon: Center(
                        child: SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(
                                strokeWidth: 2.0, color: appColor.white)),
                      ),
                      failureIcon: Center(
                        child: SvgPicture.asset(
                          AppSvg.teaBreak,
                          width: 18,
                          colorFilter: ColorFilter.mode(
                              appColor.error600, BlendMode.srcIn),
                        ),
                      ),
                      successIcon: Center(
                        child: SvgPicture.asset(
                          AppSvg.teaBreak,
                          width: 18,
                          colorFilter:
                              ColorFilter.mode(appColor.white, BlendMode.srcIn),
                        ),
                      ),
                      icon: Center(
                        child: SvgPicture.asset(
                          AppSvg.teaBreak,
                          width: 18,
                          colorFilter:
                              ColorFilter.mode(appColor.white, BlendMode.srcIn),
                        ),
                      ),
                      action: (controller) {
                        if (checkAttendanceStatus(state, "Check Out")) {
                          showSlideToStartBreakAlert(context, controller);
                        } else {
                          showSlideToStopBreakAlert(context, controller);
                        }
                      },
                      child: checkAttendanceStatus(state, "Check Out")
                          ? Text(
                              'Slide to start break',
                              style: context.textTheme.labelLarge?.copyWith(
                                  color: appColor.brand900,
                                  fontWeight: FontWeight.w500),
                            )
                          : Text(
                              'Slide to stop break',
                              style: context.textTheme.labelLarge?.copyWith(
                                  color: appColor.brand900,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  );
          }
        }
        return Container();
      },
    );
  }

  bool attendanceBreakStatus(AttendanceStatusLoaded state) {
    if (checkAttendance(state.attendanceResponse) != "Check Out") {
      return true;
    } else {
      return false;
    }
  }

  bool checkAttendanceStatus(AttendanceStatusLoaded state, String label) {
    if (checkAttendance(state.attendanceResponse) != "Both" &&
        checkAttendance(state.attendanceResponse) == label) {
      return true;
    } else {
      return false;
    }
  }

  String getTime(String? dateTime) {
    if (dateTime != null) {
      return dateTime.split(' ').last;
    }
    return '00:00:00';
  }

  String checkAttendance(AttendanceResponse attendance) {
    if (getTime(attendance.workDetails!.sTimestamp) != "00:00:00" &&
        getTime(attendance.workDetails!.eTimestamp) != "00:00:00") {
      return "Both";
    } else if (attendance.workDetails?.sTimestamp == null &&
        attendance.workDetails?.eTimestamp == null) {
      return "Check In";
    } else {
      return "Check Out";
    }
  }

  showSlideToStartBreakAlert(BuildContext context, controller) {
    final selectType = TextEditingController();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertChooseTypeDialog(type: selectType);
        }).then((value) {
      if (selectType.text != "0" && selectType.text != '') {
        controller.loading();

        Logger().w("Clicked in Check Out ${selectType.text}");
        attendanceCheckOut(context, selectType.text);
        controller.success();
        controller.reset();
        selectType.clear();
      } else {
        controller.reset();
        selectType.clear();
      }
    });
  }

  showSlideToStopBreakAlert(BuildContext context, controller) {
    attendanceCheckIn(context);
  }

  dynamic getBattery() async {
    const methodChannel = MethodChannel(AppKeys.methodChannel);
    try {
      var battery =
          await methodChannel.invokeMethod("battery", <String, dynamic>{});
      return battery;
    } catch (e) {
      Logger().e("Error while accessing native call");

      return 0;
    }
  }

  void attendanceCheckIn(BuildContext context) async {
    var battery = await getBattery();

    Logger().i(battery);
    final DataMap body = {
      'battery': battery,
      'timestamp': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      'file_path': DateFormat("yyyyMMdd_HH_mm_ss").format(DateTime.now()),
      'file_upload': "",
      // ? ""
      // : base64.encode(
      // File(capturedImage!.path).readAsBytesSync()),
      // '',
      'geo_location': {
        'latitude': latitude,
        'longitude': longitude,
        'geo_address': address,
      }
    };
    BlocProvider.of<AttendanceBloc>(context)
        .add(WorkStartLocationEvent(body: body
            // battery: (battery ?? 0).toString(),
            // filePath: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
            // fileUpload: null,
            // latitude: latitude,
            // longitude: longitude,
            // geoAddress: address,
            ));
    // BlocProvider.of<AttendanceBloc>(context).add(WorkStartLocationEvent(
    //   battery: battery,
    //   mobileTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
    //   timestamp: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
    //   latitude: latitude,
    //   longitude: longitude,
    //   geoAddress: address,
    // ));
  }

  void attendanceCheckOut(BuildContext context, String type) async {
    var battery = await getBattery();

    Logger().i(battery);
    BlocProvider.of<AttendanceBloc>(context).add(WorkEndLocationEvent(
      battery: battery,
      mobileTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      timestamp: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      taskDescription: "",
      type: int.parse(type),
      latitude: latitude,
      longitude: longitude,
      geoAddress: address,
    ));
  }
}
