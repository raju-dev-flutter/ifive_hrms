import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class ProjectTaskApprovalFormScreen extends StatefulWidget {
  final TaskData task;

  const ProjectTaskApprovalFormScreen({super.key, required this.task});

  @override
  State<ProjectTaskApprovalFormScreen> createState() =>
      _ProjectTaskApprovalFormScreenState();
}

class _ProjectTaskApprovalFormScreenState
    extends State<ProjectTaskApprovalFormScreen> with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskApprovalStream = sl<ProjectTaskApprovalStream>();

  @override
  void initState() {
    super.initState();
    taskApprovalStream.fetchInitialCallBack(widget.task);
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
          title: "Task Approval",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  void blocListener(BuildContext context, ProjectTaskCrudState state) {
    if (state is ProjectTaskCrudSuccess) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(context, "Task Successfully Approved", true);
    }
    if (state is ProjectTaskCrudFailure) {
      if (state.message == "Invalid Token") {
        BlocProvider.of<AuthenticationBloc>(context, listen: false)
            .add(const LoggedOut());
      } else if (state.message == "Network Error") {
        AppAlerts.displaySnackBar(context, state.message, false);
      } else {
        AppAlerts.displaySnackBar(context, state.message, false);
      }
    }
  }

  String status = '';

  changeState(s) => setState(() => status = s);

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocConsumer<ProjectTaskCrudBloc, ProjectTaskCrudState>(
        listener: blocListener,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                containerCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: detailCard(
                              label: 'Employee Name',
                              value: widget.task.username ?? '',
                            ),
                          ),
                          Expanded(
                            child: detailCard(
                              label: 'Status',
                              value: widget.task.status ?? '',
                            ),
                          ),
                        ],
                      ),
                      Divider(color: appColor.brand900.withOpacity(.1)),
                      detailCard(
                        label: 'Task',
                        value: widget.task.task ?? '',
                      ),
                      Divider(color: appColor.brand900.withOpacity(.1)),
                      Row(
                        children: [
                          Expanded(
                            child: detailCard(
                              label: 'Department Name',
                              value: widget.task.departmentName ?? '',
                            ),
                          ),
                          Expanded(
                            child: detailCard(
                              label: 'Date',
                              value:
                                  "${widget.task.startDate} to ${widget.task.endDate}",
                            ),
                          ),
                        ],
                      ),
                      Divider(color: appColor.brand900.withOpacity(.1)),
                      if (widget.task.refFile!.isNotEmpty)
                        Row(
                          children: [
                            networkImageView(widget.task.refFile ?? ""),
                            Dimensions.kHorizontalSpaceSmaller,
                            Expanded(
                              child: detailCard(
                                label: 'File',
                                color: appColor.error600,
                                value: widget.task.refFile ?? "",
                              ),
                            ),
                            Dimensions.kHorizontalSpaceSmaller,
                            GestureDetector(
                                onTap: () {
                                  ConvertUrl().fileDownload(
                                      ApiUrl.filePathEndPoint,
                                      widget.task.refFile.toString());
                                },
                                child: Icon(Icons.download,
                                    color: appColor.error600))
                          ],
                        ),
                    ],
                  ),
                ),
                if (widget.task.description != null &&
                    widget.task.description!.isNotEmpty) ...[
                  Dimensions.kVerticalSpaceSmall,
                  containerCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailCard(
                          label: 'Description',
                          value: widget.task.description ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
                if (widget.task.taskLogData != null &&
                    widget.task.taskLogData!.isNotEmpty) ...[
                  Dimensions.kVerticalSpaceSmall,
                  containerCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task Log Report",
                          style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: appColor.brand600.withOpacity(.7)),
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        for (var i = 0; i < 1; i++) ...[
                          containerCard(
                            color: appColor.gray100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    detailCard(
                                      label: 'Completed Percentage',
                                      value:
                                          "${widget.task.taskLogData![i].percentage ?? ''}",
                                    ),
                                  ],
                                ),
                                Dimensions.kVerticalSpaceSmaller,
                                if (widget.task.taskLogData![i].fileUpload!
                                    .isNotEmpty) ...[
                                  Row(
                                    children: [
                                      networkImageView(widget.task
                                              .taskLogData![i].fileUpload ??
                                          ""),
                                      Dimensions.kHorizontalSpaceSmaller,
                                      Expanded(
                                        child: detailCard(
                                          label: 'File',
                                          value: widget.task.taskLogData![i]
                                                  .fileUpload ??
                                              "",
                                        ),
                                      ),
                                      Dimensions.kHorizontalSpaceSmaller,
                                      GestureDetector(
                                          onTap: () {
                                            ConvertUrl().fileDownload(
                                                ApiUrl.filePathEndPoint,
                                                widget.task.taskLogData![i]
                                                    .fileUpload
                                                    .toString());
                                          },
                                          child: Icon(Icons.download,
                                              color: appColor.error600))
                                    ],
                                  ),
                                  Dimensions.kVerticalSpaceSmaller,
                                ],
                                Row(
                                  children: [
                                    detailCard(
                                      label: 'Description',
                                      value: widget.task.taskLogData![i]
                                              .completedRemarks ??
                                          widget.task.taskLogData![i]
                                              .rejectedRemarks ??
                                          widget.task.taskLogData![i]
                                              .approvedRemarks ??
                                          "",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (i != widget.task.taskLogData!.length - 1)
                            Dimensions.kVerticalSpaceSmaller
                        ],
                      ],
                    ),
                  ),
                ],
                Dimensions.kVerticalSpaceSmall,
                if (widget.task.status!.toUpperCase() != "APPROVED") ...[
                  containerCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: status != "REJECTED"
                                  ? ActionButton(
                                      onPressed: () => changeState("REJECTED"),
                                      color: appColor.gray400,
                                      textColor: appColor.white,
                                      label: "REJECT",
                                    )
                                  : ActionButton(
                                      onPressed: () => changeState(""),
                                      color: appColor.error600,
                                      textColor: appColor.white,
                                      label: "REJECT",
                                    ),
                            ),
                            Dimensions.kHorizontalSpaceSmaller,
                            Expanded(
                              child: status != "APPROVED"
                                  ? ActionButton(
                                      onPressed: () => changeState("APPROVED"),
                                      color: appColor.gray400,
                                      textColor: appColor.white,
                                      label: "APPROVE",
                                    )
                                  : ActionButton(
                                      onPressed: () => changeState(""),
                                      color: appColor.success600,
                                      textColor: appColor.white,
                                      label: "APPROVE",
                                    ),
                            ),
                          ],
                        ),
                        Dimensions.kVerticalSpaceSmall,
                        // if (status != "REJECTED") ...[
                        //   CustomTextFormField(
                        //     label: "Completed Percentage",
                        //     controller: taskApprovalStream.percentageController,
                        //     maxLines: 1,
                        //     keyboardType: TextInputType.number,
                        //     inputFormatters: [
                        //       FilteringTextInputFormatter.digitsOnly
                        //     ],
                        //     validator: (val) {
                        //       if (int.parse(val!) > 100) {
                        //         return "Please enter the value below 100%";
                        //       }
                        //       return null;
                        //     },
                        //     required: true,
                        //   ),
                        //   Dimensions.kVerticalSpaceSmall,
                        // ],
                        if (status != "REJECTED") ...[
                          addCaptureImageButton(),
                          Dimensions.kVerticalSpaceSmall,
                          StreamBuilder<List<File>>(
                              stream: taskApprovalStream.captureImageSubject,
                              builder: (context, snapshot) {
                                final cd = snapshot.data ?? [];
                                if (cd.isEmpty) return Container();
                                return Column(
                                  children: [
                                    for (var i = 0; i < cd.length; i++) ...[
                                      Row(children: [
                                        captureImageView(cd[i], cd, i),
                                        Dimensions.kHorizontalSpaceSmaller,
                                        Expanded(
                                          child: Text(
                                            cd[i].path.split('/').last,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: context.textTheme.labelSmall
                                                ?.copyWith(
                                                    color: appColor.blue700),
                                          ),
                                        ),
                                      ]),
                                      Dimensions.kVerticalSpaceSmall,
                                    ],
                                  ],
                                );
                              }),
                        ],
                        CustomTextFormField(
                          label: "Description",
                          controller: taskApprovalStream.descriptionController,
                          maxLines: 3,
                          required: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required";
                            }
                            return null;
                          },
                        ),
                        if (status.isNotEmpty) ...[
                          Dimensions.kVerticalSpaceLarge,
                          state is ProjectTaskCrudLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ActionButton(
                                  onPressed: onSubmit,
                                  color: appColor.warning600,
                                  child: Text(
                                    'UPDATE',
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(color: appColor.white),
                                  ),
                                ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget containerCard({required Widget child, Color? color}) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      decoration: BoxDecoration(
        color: color ?? appColor.white,
        borderRadius: BorderRadius.circular(8).w,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF5F5F5).withOpacity(.2),
            blurRadius: 12,
            offset: const Offset(0, 3),
            spreadRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget detailCard(
      {required String label, required String value, Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelMedium
              ?.copyWith(color: appColor.gray700, letterSpacing: .5),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500, color: color, letterSpacing: .5),
        ),
      ],
    );
  }

  Widget networkImageView(String document) {
    return Stack(
      children: [
        if (document.split('.').last == "png" ||
            document.split('.').last == '.jpg' ||
            document.split('.').last == '.jpeg')
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              border: Border.all(color: appColor.brand600),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${ApiUrl.filePathEndPoint}/$document")),
            ),
          )
        else
          Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              border: Border.all(color: appColor.brand600),
            ),
            child: Icon(Icons.attach_file, color: appColor.error300),
          ),
      ],
    );
  }

  Widget captureImageView(File document, List<File> listDocument, int index) {
    return Stack(
      children: [
        if (document.path.endsWith('.png') ||
            document.path.endsWith('.jpg') ||
            document.path.endsWith('.jpeg'))
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              border: Border.all(color: appColor.brand600),
              image: DecorationImage(
                  fit: BoxFit.cover, image: FileImage(document)),
            ),
          )
        else
          Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              border: Border.all(color: appColor.brand600),
            ),
            child: Icon(Icons.edit_document, color: appColor.error300),
          ),
        Positioned(
          right: 2,
          bottom: 6.h,
          child: GestureDetector(
            onTap: () {
              for (var i = 0; i < listDocument.length; i++) {
                if (index == i) listDocument.removeAt(i);
              }
              taskApprovalStream.addCaptureImage(listDocument);
            },
            child: Icon(Icons.delete, color: appColor.error600),
          ),
        ),
      ],
    );
  }

  Widget addCaptureImageButton() {
    return InkWell(
      onTap: () => displayCaptureCameraModeAlert(onPressed: () {}),
      borderRadius: BorderRadius.circular(8).w,
      child: DottedBorder(
        color: appColor.blue600,
        borderType: BorderType.RRect,
        radius: const Radius.circular(8).w,
        strokeWidth: 1,
        dashPattern: const [3],
        child: Container(
          height: 42.h,
          alignment: Alignment.center,
          padding: Dimensions.kPaddingAllSmall,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo_rounded,
                  size: 14.w, color: appColor.blue600),
              Dimensions.kHorizontalSpaceSmaller,
              Text(
                'Add Image',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1, color: appColor.blue600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      taskApprovalStream.onSubmit(context, widget.task, status);
    }
  }

  displayCaptureCameraModeAlert({required VoidCallback onPressed}) {
    showAdaptiveDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: Dimensions.kPaddingAllMedium,
                  width: context.deviceSize.width,
                  decoration: BoxDecoration(
                    color: appColor.brand600,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ).w,
                  ),
                  child: Text(
                    "Select Mode",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: appColor.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: context.deviceSize.width,
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(
                    color: appColor.gray50,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ).w,
                  ),
                  child: Row(
                    children: [
                      Dimensions.kHorizontalSpaceMedium,
                      Expanded(
                        child: ActionButton(
                          height: 50,
                          onPressed: () =>
                              {Navigator.pop(context), selectCameraPicker()},
                          color: appColor.blue100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera, color: appColor.blue700),
                              Dimensions.kHorizontalSpaceSmaller,
                              Text(
                                "Camera",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(color: appColor.blue700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Expanded(
                        child: ActionButton(
                          height: 50,
                          onPressed: () =>
                              {Navigator.pop(context), selectGalleryPicker()},
                          color: appColor.blue100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder, color: appColor.blue700),
                              Dimensions.kHorizontalSpaceSmaller,
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(color: appColor.blue700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Dimensions.kHorizontalSpaceMedium,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void selectCameraPicker() async {
    final imagePicker = ImagePicker();
    List<File> oldDocument =
        taskApprovalStream.captureImageSubject.valueOrNull ?? [];
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      oldDocument.add(File(pickedFile.path));
      taskApprovalStream.addCaptureImage(oldDocument);
      setState(() {});
    }
  }

  void selectGalleryPicker() async {
    final imagePicker = ImagePicker();
    List<File> oldDocument =
        taskApprovalStream.captureImageSubject.valueOrNull ?? [];
    final pickedFile = await imagePicker.pickMultipleMedia();
    if (pickedFile.isNotEmpty) {
      for (var pic in pickedFile) {
        oldDocument.add(File(pic.path));
      }

      taskApprovalStream.addCaptureImage(oldDocument);
      setState(() {});
    }
  }
}
