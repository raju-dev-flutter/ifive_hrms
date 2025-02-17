import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../dashboard/dashboard.dart';
import '../../../../food/food.dart';
import '../../../attendance.dart';

class AttendanceActionCard extends StatelessWidget {
  final AttendanceStream attendanceStream;

  const AttendanceActionCard({super.key, required this.attendanceStream});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: multiBlocListener(),
      child: BlocBuilder<AttendanceStatusCubit, AttendanceStatusState>(
        builder: (context, state) {
          if (state is AttendanceStatusLoading) {
            return const CircularProgressIndicator();
          }
          if (state is AttendanceStatusLoaded) {
            if (checkAttendance(state.attendanceResponse) == "Both") {
              return BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  if (state is AttendanceLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ActionButton(
                    onPressed: () => attendanceStream.onSubmitCheckIn(context),
                    label: 'AGAIN CHECK IN',
                  );
                },
              );
            } else if (checkAttendanceStatus(state, "Check In")) {
              return Column(
                children: [
                  InkWell(
                    onTap: () => showBottomCameraModel(context),
                    borderRadius: BorderRadius.circular(12),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      color: appColor.blue500,
                      dashPattern: const [8, 4],
                      padding: const EdgeInsets.all(4),
                      child: StreamBuilder<XFile?>(
                          stream: attendanceStream.capturedImage,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: FileImage(File(snapshot.data!.path)),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: appColor.blue50.withOpacity(.8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_rounded,
                                      size: 60, color: appColor.blue600),
                                  Dimensions.kVerticalSpaceSmallest,
                                  attendanceStream.capturedImageLoading
                                              .valueOrNull ==
                                          true
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : Text(
                                          'PLEASE TAKE A PHOTO',
                                          style: context.textTheme.labelMedium
                                              ?.copyWith(
                                                  color: appColor.blue600,
                                                  fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  Container(
                    padding: Dimensions.kPaddingAllSmaller,
                    decoration: BoxDecoration(
                      color: appColor.gray100,
                      borderRadius: Dimensions.kBorderRadiusAllSmaller,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: Dimensions.iconSizeSmaller,
                          color: appColor.error600,
                        ),
                        Dimensions.kHorizontalSpaceSmaller,
                        StreamBuilder<String?>(
                            stream: attendanceStream.geoAddress,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const CircularProgressIndicator();
                              }
                              return Expanded(
                                child: Text(
                                  snapshot.data ?? '',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                          color: appColor.gray700,
                                          fontWeight: FontWeight.bold),
                                ),
                              );
                            }),
                        Dimensions.kHorizontalSpaceSmallest,
                        IconButton(
                          onPressed: attendanceStream.getCurrentLocation,
                          icon: Icon(
                            Icons.refresh_rounded,
                            size: Dimensions.iconSizeSmaller,
                            color: appColor.blue600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  attendanceStream.capturedImage.valueOrNull == null ||
                          attendanceStream.geoAddress.valueOrNull == null
                      ? const DefaultActionButton(label: 'CHECK IN')
                      : BlocBuilder<AttendanceBloc, AttendanceState>(
                          builder: (context, state) {
                            if (state is AttendanceLoading) {
                              return const CircularProgressIndicator();
                            }
                            return ActionButton(
                              onPressed: () =>
                                  attendanceStream.onSubmitCheckIn(context),
                              label: 'CHECK IN',
                            );
                          },
                        ),
                ],
              );
            } else if (checkAttendanceStatus(state, "Check Out")) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Day Summery', style: context.textTheme.labelLarge),
                  Dimensions.kVerticalSpaceSmallest,
                  TextFormField(
                    controller: attendanceStream.descriptionController,
                    keyboardType: TextInputType.text,
                    enableSuggestions: true,
                    obscureText: false,
                    enableInteractiveSelection: true,
                    style: context.textTheme.bodySmall,
                    maxLines: 4,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: appColor.gray700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF61A9FB)),
                      ),
                      labelStyle: context.textTheme.bodySmall,
                      contentPadding: Dimensions.kPaddingAllSmall,
                      errorStyle: context.textTheme.labelMedium
                          ?.copyWith(color: appColor.error600),
                    ),
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  Container(
                    padding: Dimensions.kPaddingAllSmaller,
                    decoration: BoxDecoration(
                      color: appColor.gray100,
                      borderRadius: Dimensions.kBorderRadiusAllSmaller,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: Dimensions.iconSizeSmaller,
                          color: appColor.error600,
                        ),
                        Dimensions.kHorizontalSpaceSmaller,
                        StreamBuilder<String?>(
                            stream: attendanceStream.geoAddress,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const CircularProgressIndicator();
                              }
                              return Expanded(
                                child: Text(
                                  snapshot.data ?? '',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                          color: appColor.gray700,
                                          fontWeight: FontWeight.bold),
                                ),
                              );
                            }),
                        Dimensions.kHorizontalSpaceSmallest,
                        IconButton(
                          onPressed: attendanceStream.getCurrentLocation,
                          icon: Icon(
                            Icons.refresh_rounded,
                            size: Dimensions.iconSizeSmaller,
                            color: appColor.blue600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  attendanceStream.geoAddress.valueOrNull == null
                      ? const DefaultActionButton(label: 'CHECK OUT')
                      : BlocBuilder<AttendanceBloc, AttendanceState>(
                          builder: (context, state) {
                            if (state is AttendanceLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return ActionButton(
                              onPressed: () =>
                                  attendanceStream.onSubmitCheckOut(context),
                              label: 'CHECK OUT',
                            );
                          },
                        ),
                ],
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  multiBlocListener() {
    return [
      BlocListener<AttendanceBloc, AttendanceState>(listener: (context, state) {
        if (state is AttendanceSuccess) {
          BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
              .getAttendanceStatus(SharedPrefs().getToken());
          BlocProvider.of<FoodAttendanceStatusCubit>(context, listen: false)
              .getFoodAttendanceStatus();
        }
        if (state is AttendanceFailed) {
          Navigator.pop(context);
          AppAlerts.displaySnackBar(context, state.message, false);
        }
      }),
      BlocListener<FoodAttendanceStatusCubit, FoodAttendanceStatusState>(
          listener: (context, state) {
        if (state is FoodAttendanceStatusLoaded) {
          if (state.foodAttendanceResponse.message == '') {
            if (PickDateTime().checkAvailableTime(TimeOfDay.now())) {
              showFoodAttendanceAlert(context);
            }
          }
        }
      }),
      BlocListener<FoodAttendanceBloc, FoodAttendanceState>(
        listener: (context, state) {
          if (state is UpdateFoodAttendanceSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Your Lunch booking successfully", true);
          }
          if (state is UpdateFoodAttendanceFailed) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        },
      ),
    ];
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

  void continueAttendance(BuildContext context, String label) async {
    bool isContinue = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const AttendanceContinueAlert());
    if (isContinue == true) {
      attendanceStream.onSubmitCheckIn(context);
    }
  }

  void showBottomCameraModel(BuildContext context) async {
    attendanceStream.captureImageLoading();
    await availableCameras().then((availableCamera) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (_) => AttendanceFrontCameraWidget(
            cameras: availableCamera, attendanceStream: attendanceStream)));
  }

  void showFoodAttendanceAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<FoodAttendanceBloc, FoodAttendanceState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: appColor.white,
              alignment: Alignment.center,
              title: Text(
                "Food Attendance",
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500, color: appColor.gray700),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Dimensions.kVerticalSpaceSmaller,
                  SvgPicture.asset(
                    AppSvg.foodFill,
                    colorFilter:
                        ColorFilter.mode(appColor.warning600, BlendMode.srcIn),
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text(
                    "Do you want to\nfood?",
                    textAlign: TextAlign.center,
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  state is UpdateFoodAttendanceLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => {
                                Navigator.pop(context),
                                Navigator.pop(context)
                              },
                              child: Text(
                                "LATER",
                                style: context.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: appColor.warning600),
                              ),
                            ),
                            TextButton(
                              onPressed: () => attendanceStream.onSubmitFood(
                                  context, "No Need"),
                              child: Text(
                                "NO NEED",
                                style: context.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: appColor.error600),
                              ),
                            ),
                            TextButton(
                              onPressed: () => attendanceStream.onSubmitFood(
                                  context, "Need"),
                              child: Text(
                                "NEED",
                                style: context.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: appColor.success600),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AttendanceFrontCameraWidget extends StatefulWidget {
  final List<CameraDescription>? cameras;

  final AttendanceStream attendanceStream;

  const AttendanceFrontCameraWidget(
      {super.key, this.cameras, required this.attendanceStream});

  @override
  State<AttendanceFrontCameraWidget> createState() =>
      _AttendanceFrontCameraWidgetState();
}

class _AttendanceFrontCameraWidgetState
    extends State<AttendanceFrontCameraWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  bool _isCameraInitialized = false;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.medium;

  @override
  void initState() {
    super.initState();
    onNewCameraSelected(widget.cameras![1]);

    // RawKeyboard.instance.addListener(_handleKeyEvent);
  }

  // void _handleKeyEvent(RawKeyEvent event) {
  //   if (event is RawKeyDownEvent &&
  //       event.physicalKey == PhysicalKeyboardKey.audioVolumeUp) {
  //     takePicture();
  //   }
  // }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    if (mounted) setState(() => controller = cameraController);

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      Logger().e('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() => _isCameraInitialized = controller!.value.isInitialized);
    }

    // VolumeController().listener((volume) {
    //   if (volume == 0) {
    //     takePicture();
    //   }
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    // RawKeyboard.instance.removeListener(_handleKeyEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor.gray950,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (_isCameraInitialized)
              ? AspectRatio(
                  aspectRatio: 1 / controller!.value.aspectRatio,
                  child: controller!.buildPreview(),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(child: CircularProgressIndicator()),
                ),
          Container(
            width: context.deviceSize.width,
            height: context.deviceSize.height * 0.20,
            decoration: BoxDecoration(color: appColor.gray950),
            child: GestureDetector(
              onTap: takePicture,
              child: Icon(
                Icons.circle,
                color: Colors.white,
                size: 80.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {}
    try {
      XFile file = await cameraController.takePicture();
      widget.attendanceStream.captureImage(file);
      Navigator.pop(context);
    } on CameraException catch (e) {
      Logger().e('Error occurred while taking picture: $e');
    }
  }
}
