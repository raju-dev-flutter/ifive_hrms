import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../database.dart';

class DatabaseCameraScreen extends StatefulWidget {
  const DatabaseCameraScreen({super.key});

  @override
  State<DatabaseCameraScreen> createState() => _DatabaseCameraScreenState();
}

class _DatabaseCameraScreenState extends State<DatabaseCameraScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final databaseCameraStream = sl<DatabaseCameraStream>();

  @override
  void initState() {
    super.initState();
    databaseCameraStream.fetchInitialCallBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Database Camera",
        ),
      ),
      body: BlocListener<SfaCrudBloc, SfaCrudState>(
        listener: (context, state) {
          if (state is SfaCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Image Updated Successfully", true);
          }
          if (state is SfaCrudFailed) {
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        },
        child: Container(
          padding: Dimensions.kPaddingAllMedium,
          child: _buildBodyUI(),
        ),
      ),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: context.deviceSize.width,
            height: 300.h,
            padding: Dimensions.kPaddingAllSmall,
            decoration: BoxDecoration(
              color: appColor.white,
              borderRadius: Dimensions.kBorderRadiusAllSmall,
              boxShadow: [
                BoxShadow(
                  color: appColor.gray200.withOpacity(.2),
                  blurRadius: 6,
                  spreadRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Stack(
              children: [
                StreamBuilder<XFile?>(
                    stream: databaseCameraStream.capturedImage,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            color: appColor.white,
                            borderRadius: Dimensions.kBorderRadiusAllSmall,
                            image: DecorationImage(
                              image: FileImage(File(snapshot.data!.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return Container();
                    }),
                Positioned(
                  right: 20,
                  bottom: 10,
                  child: ActionButton(
                    width: 100.w,
                    height: 36.h,
                    color: appColor.gray800.withOpacity(.8),
                    onPressed: databaseCameraStream.takeImage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: appColor.white,
                          size: 16.w,
                        ),
                        Dimensions.kHorizontalSpaceSmaller,
                        Text(
                          "ReTake",
                          style: context.textTheme.labelLarge
                              ?.copyWith(color: appColor.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Dimensions.kVerticalSpaceSmaller,
          StreamBuilder<bool>(
            stream: databaseCameraStream.gprsLocationScanning,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return const CircularProgressIndicator();
              }
              return _LocationScanningWidget(
                databaseCameraStream: databaseCameraStream,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LocationScanningWidget extends StatelessWidget {
  final DatabaseCameraStream databaseCameraStream;

  const _LocationScanningWidget(
      {super.key, required this.databaseCameraStream});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SfaCrudBloc, SfaCrudState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: appColor.white,
                borderRadius: Dimensions.kBorderRadiusAllSmall,
                boxShadow: [
                  BoxShadow(
                    color: appColor.gray200.withOpacity(.2),
                    blurRadius: 6,
                    spreadRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: StreamBuilder<String?>(
                stream: databaseCameraStream.geoAddress,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const CircularProgressIndicator();
                  }
                  return Text(
                    snapshot.data ?? '',
                    style: context.textTheme.labelMedium?.copyWith(
                        color: appColor.gray700, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomTextFormField(
              label: "Remarks",
              maxLines: 4,
              controller: databaseCameraStream.remarksController,
              required: false,
            ),
            Dimensions.kVerticalSpaceLarger,
            state is SfaCrudLoading
                ? const Center(child: CircularProgressIndicator())
                : ActionButton(
                    onPressed: () => databaseCameraStream.onSubmit(context),
                    label: 'SUBMIT',
                  ),
          ],
        );
      },
    );
  }
}
