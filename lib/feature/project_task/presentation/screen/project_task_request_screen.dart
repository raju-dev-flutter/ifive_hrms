import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../project_task.dart';

class ProjectTaskRequestScreen extends StatefulWidget {
  const ProjectTaskRequestScreen({super.key});

  @override
  State<ProjectTaskRequestScreen> createState() =>
      _ProjectTaskRequestScreenState();
}

class _ProjectTaskRequestScreenState extends State<ProjectTaskRequestScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskRequestStream = sl<ProjectTaskRequestStream>();

  @override
  void initState() {
    super.initState();
    taskRequestStream.fetchInitialCallBack();
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
          title: "Add Task",
        ),
      ),
      body: BlocListener<ProjectTaskCrudBloc, ProjectTaskCrudState>(
        listener: (context, state) {
          if (state is ProjectTaskCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Task Successfully Updated", true);
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
        },
        child: _buildBodyUI(),
      ),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStreamDropDownWidget(
              label: "Project",
              required: true,
              streamList: taskRequestStream.projectList,
              valueListInit: taskRequestStream.projectListInit,
              onChanged: (params) {
                taskRequestStream.project(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmall,
            CustomTextFormField(
              label: "Activity",
              controller: taskRequestStream.activityController,
              maxLines: 1,
              required: true,
            ),
            Dimensions.kVerticalSpaceSmall,
            CustomStreamDropDownWidget(
              label: "Department",
              required: true,
              streamList: taskRequestStream.departmentList,
              valueListInit: taskRequestStream.departmentListInit,
              onChanged: (params) {
                taskRequestStream.department(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmall,
            CustomStreamDropDownWidget(
              label: "Lead Responsibility",
              required: true,
              streamList: taskRequestStream.leadResponsibilityList,
              valueListInit: taskRequestStream.leadResponsibilityListInit,
              onChanged: (params) {
                taskRequestStream.leadResponsibility(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmall,
            CustomStreamDropDownWidget(
              label: "Approve By",
              required: true,
              streamList: taskRequestStream.approveByList,
              valueListInit: taskRequestStream.approveByListInit,
              onChanged: (params) {
                taskRequestStream.approveBy(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            // Dimensions.kVerticalSpaceSmall,
            // CustomStreamDropDownWidget(
            //   label: "Type",
            //   required: true,
            //   streamList: taskRequestStream.typeList,
            //   valueListInit: taskRequestStream.typeListInit,
            //   onChanged: (params) {
            //     taskRequestStream.type(params);
            //     setState(() {});
            //   },
            //   validator: (val) {
            //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
            //     return null;
            //   },
            // ),
            Dimensions.kVerticalSpaceSmall,
            CustomDateTimeTextFormField(
              label: 'Start Date',
              required: true,
              controller: TextEditingController(
                  text: taskRequestStream.selectedStartDate.valueOrNull ?? ''),
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: taskRequestStream.startDate.valueOrNull,
                    startDate: DateTime.now());
                taskRequestStream.selectStartDate(date);
                setState(() {});
              },
            ),
            Dimensions.kVerticalSpaceSmall,
            CustomDateTimeTextFormField(
              label: 'End Date',
              required: true,
              controller: TextEditingController(
                  text: taskRequestStream.selectedEndDate.valueOrNull ?? ''),
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: taskRequestStream.endDate.valueOrNull,
                    startDate: DateTime.now());
                taskRequestStream.selectEndDate(date);
                setState(() {});
              },
            ),
            Dimensions.kVerticalSpaceSmall,
            CustomTextFormField(
              label: "Address",
              controller: taskRequestStream.addressController,
              maxLines: 1,
              required: true,
            ),

            Dimensions.kVerticalSpaceSmall,
            CustomTextFormField(
              label: "Comments",
              controller: taskRequestStream.commentsController,
              maxLines: 3,
              required: true,
            ),
            Dimensions.kVerticalSpaceSmall,
            RichText(
              text: TextSpan(
                text: "Attachment ",
                style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400, color: appColor.gray500),
                children: [
                  TextSpan(
                    text: "*",
                    style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400, color: appColor.error600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),

            StreamBuilder<List<File>>(
                stream: taskRequestStream.captureImageSubject,
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
                                  ?.copyWith(color: appColor.blue700),
                            ),
                          ),
                        ]),
                        Dimensions.kVerticalSpaceSmall,
                      ],
                    ],
                  );
                }),
            Dimensions.kVerticalSpaceSmall,
            addCaptureImageButton(),
            Dimensions.kVerticalSpaceLarge,
            Dimensions.kVerticalSpaceLarge,
            BlocBuilder<ProjectTaskCrudBloc, ProjectTaskCrudState>(
              builder: (context, state) {
                if (state is ProjectTaskCrudLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ActionButton(
                  onPressed: onSubmit,
                  color: appColor.warning600,
                  child: Text(
                    'SUBMIT',
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: appColor.white),
                  ),
                );
              },
            ),
            Dimensions.kVerticalSpaceLargest,
          ],
        ),
      ),
    );
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      taskRequestStream.onSubmit(context);
    }
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
              taskRequestStream.addCaptureImage(listDocument);
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
        taskRequestStream.captureImageSubject.valueOrNull ?? [];
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      oldDocument.add(File(pickedFile.path));
      taskRequestStream.addCaptureImage(oldDocument);
      setState(() {});
    }
  }

  void selectGalleryPicker() async {
    final imagePicker = ImagePicker();
    List<File> oldDocument =
        taskRequestStream.captureImageSubject.valueOrNull ?? [];
    final pickedFile = await imagePicker.pickMultipleMedia();
    if (pickedFile.isNotEmpty) {
      for (var pic in pickedFile) {
        oldDocument.add(File(pic.path));
      }

      taskRequestStream.addCaptureImage(oldDocument);
      setState(() {});
    }
  }
}
