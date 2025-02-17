import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdateEducationScreen extends StatefulWidget {
  const ProfileUpdateEducationScreen({super.key});

  @override
  State<ProfileUpdateEducationScreen> createState() =>
      _ProfileUpdateEducationScreenState();
}

class _ProfileUpdateEducationScreenState
    extends State<ProfileUpdateEducationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final educationStream = sl<ProfileEducationStream>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Education Details",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddEducationDetailBottomModelSheet,
        label: const Icon(Icons.add),
      ),
      body: _buildBodyUI(),
    );
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      educationStream.onClose();
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
    }
  }

  _buildBodyUI() {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocListener<AccountCrudBloc, AccountCrudState>(
        listener: accountListener,
        child: BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
          builder: (context, state) {
            if (state is AccountDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AccountDetailsLoaded) {
              final educationList = state.profile.education!;
              if (educationList.isEmpty) {
                return Center(child: EmptyScreen(onPressed: () async {
                  BlocProvider.of<AccountDetailsCubit>(context)
                      .getAccountDetails();
                }));
              }
              return ListView.builder(
                  itemCount: educationList.length,
                  itemBuilder: (_, i) {
                    return _$DraggableEducationCardUI(educationList[i], i);
                  });
            }
            if (state is AccountDetailsFailed) {
              return Center(child: EmptyScreen(onPressed: () async {
                BlocProvider.of<AccountDetailsCubit>(context)
                    .getAccountDetails();
              }));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _$DraggableEducationCardUI(Education education, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Slidable(
        key: ValueKey(index),
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) =>
                  showAddEducationWithDetailBottomModelSheet(education),
              backgroundColor: appColor.blue100,
              foregroundColor: appColor.blue600,
              icon: Icons.update,
              label: "Update",
              borderRadius: BorderRadius.circular(8).w,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: .3,
          children: [
            SlidableAction(
              onPressed: (_) => educationStream.onDelete(context, education),
              backgroundColor: appColor.error100,
              foregroundColor: appColor.error500,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.circular(8).w,
            ),
          ],
        ),
        child: _$EducationCardUI(education),
      ),
    );
  }

  Widget _$EducationCardUI(Education education) {
    return InkWell(
      onDoubleTap: () => showAddEducationWithDetailBottomModelSheet(education),
      borderRadius: BorderRadius.circular(8).w,
      child: Container(
        padding: Dimensions.kPaddingAllSmall,
        decoration: BoxDecoration(
          color: appColor.white,
          borderRadius: BorderRadius.circular(8).w,
          border: Border.all(color: appColor.orange100, width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF5F5F5).withOpacity(.2),
              blurRadius: 12,
              offset: const Offset(0, 3),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.education,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.orange500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "${education.course ?? ""},\n"),
                        TextSpan(text: "${education.schoolName ?? ""},\n"),
                        TextSpan(text: "${education.schoolBoard ?? ""},\n"),
                        TextSpan(
                          text: "Course | Institution | University",
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                // Icon(Icons.more_vert_rounded),
              ],
            ),
            Dimensions.kVerticalSpaceSmaller,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppSvg.degree,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.orange500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.labelMedium,
                      children: [
                        TextSpan(
                          text: "${education.educationLevelName ?? ''}\n",
                          style: context.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: "Education Level"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Dimensions.kVerticalSpaceSmaller,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppSvg.achievement,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.orange500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.labelMedium,
                      children: [
                        TextSpan(
                          text: "${education.percentage ?? '0'} %\n",
                          style: context.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: "Percentage / Grade"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddEducationDetailBottomModelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => EducationBottomSheet(
          formKey: _formKey, educationStream: educationStream),
    );
  }

  void showAddEducationWithDetailBottomModelSheet(Education? e) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => EducationBottomSheet(
          formKey: _formKey, educationStream: educationStream, education: e),
    );
  }
}

class EducationBottomSheet extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ProfileEducationStream educationStream;
  final Education? education;

  const EducationBottomSheet(
      {super.key,
      required this.formKey,
      required this.educationStream,
      this.education});

  @override
  State<EducationBottomSheet> createState() => _EducationBottomSheetState();
}

class _EducationBottomSheetState extends State<EducationBottomSheet>
    with InputValidationMixin {
  @override
  void initState() {
    super.initState();
    if (widget.education != null) {
      widget.educationStream.fetchInitialCallBackWithDetail(widget.education);
    } else {
      widget.educationStream.fetchInitialCallBack();
    }
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      Navigator.pop(context);
      widget.educationStream.onClose();
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      AppAlerts.displaySnackBar(
          context, "Office Detail Updated Successfully", true);
    }
    if (state is AccountCrudFailed) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(context, "Office Detail Updated Failed", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor.white,
      width: context.deviceSize.width,
      height: context.deviceSize.height,
      padding: Dimensions.kPaddingAllMedium,
      child: BlocListener<AccountCrudBloc, AccountCrudState>(
        listener: accountListener,
        child: StreamBuilder<bool>(
            stream: widget.educationStream.isLoading,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dimensions.kVerticalSpaceLargest,
                      Dimensions.kVerticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Education Details',
                              style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: appColor.brand800)),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.cancel_rounded,
                                color: appColor.error600),
                          ),
                        ],
                      ),
                      Dimensions.kVerticalSpaceSmall,
                      CustomTextFormField(
                        label: "Course",
                        controller: widget.educationStream.course,
                        required: true,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomStreamDropDownWidget(
                        label: "Education level",
                        streamList: widget.educationStream.educationLevel,
                        required: true,
                        initialData: widget.education?.educationLevelName ?? '',
                        valueListInit:
                            widget.educationStream.educationLevelListInit,
                        onChanged: (val) {
                          if (val != '') {
                            widget.educationStream.selectedEducationLevel(val);
                          }
                          // setState(() {});
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomTextFormField(
                        label: "Name of the Institution",
                        controller: widget.educationStream.nameOfTheInstitution,
                        required: true,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomTextFormField(
                        label: "Boards of Education/University",
                        controller: widget.educationStream.boardsOfEducation,
                        required: true,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomDateTimeTextFormField(
                        label: "From",
                        required: true,
                        controller: TextEditingController(
                            text: widget.educationStream.selectFromDate
                                    .valueOrNull ??
                                ''),
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!)) {
                            return "required *";
                          }
                          return null;
                        },
                        onPressed: () async {
                          DateTime date = await PickDateTime.date(context,
                              selectedDate:
                                  widget.educationStream.fromDate.valueOrNull,
                              startDate: null);
                          widget.educationStream.selectedFromDate(date);
                          // setState(() {});
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomDateTimeTextFormField(
                        label: "To",
                        required: true,
                        controller: TextEditingController(
                            text: widget
                                    .educationStream.selectToDate.valueOrNull ??
                                ''),
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!)) {
                            return "required *";
                          }
                          return null;
                        },
                        onPressed: () async {
                          DateTime date = await PickDateTime.date(context,
                              selectedDate:
                                  widget.educationStream.toDate.valueOrNull,
                              startDate: null);
                          widget.educationStream.selectedToDate(date);
                          // setState(() {});
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomTextFormField(
                        label: "Percentage / Grade",
                        controller: widget.educationStream.percentage,
                        required: true,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      RichText(
                        text: TextSpan(
                          text: "File",
                          style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: appColor.gray700.withOpacity(.8)),
                          children: [
                            TextSpan(
                              text: "",
                              style: context.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: appColor.error600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      StreamBuilder<File?>(
                          stream: widget.educationStream.file,
                          builder: (context, snapshot) {
                            final file = snapshot.data;
                            return Row(
                              children: [
                                InkWell(
                                  onTap: widget.educationStream.selectedFile,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius: Dimensions
                                              .kBorderRadiusAllSmallest,
                                          border: Border.all(
                                              color: appColor.brand600),
                                          image: file != null
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(file))
                                              : null,
                                        ),
                                        child: Icon(
                                          file != null
                                              ? Icons.photo_album
                                              : Icons.add_a_photo_rounded,
                                          color: appColor.blue600,
                                        ),
                                      ),
                                      if (file != null)
                                        Positioned(
                                          right: 2,
                                          bottom: 4.h,
                                          child: GestureDetector(
                                            onTap: widget
                                                .educationStream.removeFile,
                                            child: Icon(
                                                Icons.change_circle_outlined,
                                                color: appColor.error600),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Dimensions.kHorizontalSpaceSmaller,
                                if (file != null)
                                  Expanded(
                                    child: Text(
                                      file.path.split('/').last,
                                      maxLines: 2,
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(color: appColor.blue700),
                                    ),
                                  ),
                              ],
                            );
                          }),
                      Dimensions.kVerticalSpaceLarge,
                      BlocBuilder<AccountCrudBloc, AccountCrudState>(
                        builder: (context, state) {
                          if (state is AccountCrudLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ActionButton(
                            onPressed: widget.education != null
                                ? () => widget.educationStream
                                    .onUpdate(context, widget.education!)
                                : () =>
                                    widget.educationStream.onSubmit(context),
                            child: Text(
                              widget.education != null ? 'UPDATE' : 'SUBMIT',
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: appColor.white),
                            ),
                          );
                        },
                      ),
                      Dimensions.kVerticalSpaceSmall,
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
