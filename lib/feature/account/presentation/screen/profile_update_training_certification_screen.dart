import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class ProfileUpdateTrainingCertificationScreen extends StatefulWidget {
  const ProfileUpdateTrainingCertificationScreen({super.key});

  @override
  State<ProfileUpdateTrainingCertificationScreen> createState() =>
      _ProfileUpdateTrainingCertificationScreenState();
}

class _ProfileUpdateTrainingCertificationScreenState
    extends State<ProfileUpdateTrainingCertificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final trainingCertificationStream = sl<ProfileTrainingCertificationStream>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Training And Certification Details",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddTCDetailBottomModelSheet,
        label: const Icon(Icons.add),
      ),
      body: _buildBodyUI(),
    );
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      // Navigator.pop(context);
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      // AppAlerts.displaySnackBar(context,
      //     "Training And Certification Detail Updated Successfully", true);
    }
    if (state is AccountCrudFailed) {
      // Navigator.pop(context);
      AppAlerts.displaySnackBar(
          context, "Training And Certification Detail Updated Failed", false);
    }
  }

  _buildBodyUI() {
    return BlocListener<AccountCrudBloc, AccountCrudState>(
      listener: accountListener,
      child: BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
        builder: (context, state) {
          if (state is AccountDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AccountDetailsLoaded) {
            final trainingCertification = state.profile.trainingCertification!;
            if (trainingCertification.isEmpty) {
              return Center(child: EmptyScreen(onPressed: () async {
                BlocProvider.of<AccountDetailsCubit>(context)
                    .getAccountDetails();
              }));
            }
            return ListView.builder(
                padding: Dimensions.kPaddingAllMedium,
                itemCount: trainingCertification.length,
                itemBuilder: (_, i) {
                  return _$DraggableTrainingAndCertificationCardUI(
                      trainingCertification[i], i);
                });
          }
          if (state is AccountDetailsFailed) {
            return Center(child: EmptyScreen(onPressed: () async {
              BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
            }));
          }
          return Container();
        },
      ),
    );
  }

  Widget _$DraggableTrainingAndCertificationCardUI(
      TrainingCertification tc, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Slidable(
        key: ValueKey(index),
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => showAddTCWithDetailBottomModelSheet(tc),
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
              onPressed: (_) =>
                  trainingCertificationStream.onDelete(context, tc),
              backgroundColor: appColor.error100,
              foregroundColor: appColor.error500,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.circular(8).w,
            ),
          ],
        ),
        child: _$TrainingAndCertificationCardUI(tc),
      ),
    );
  }

  _$TrainingAndCertificationCardUI(TrainingCertification tc) {
    return InkWell(
      onDoubleTap: () => showAddTCWithDetailBottomModelSheet(tc),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            TextSpan(text: "${tc.courseName ?? ""},\n"),
                            TextSpan(text: "${tc.certificateName ?? ""}.\n"),
                            TextSpan(
                              text: "Course Name | Certificate Name",
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
                              text: "${tc.certificateLevelName}\n",
                              style: context.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: "Certificate Level"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Dimensions.kVerticalSpaceSmaller,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.date,
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
                            TextSpan(
                                text: "${tc.courseDuration ?? ""} Months\n"),
                            TextSpan(
                              text: "Course Duration",
                              style: context.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Icon(Icons.more_vert_rounded),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddTCDetailBottomModelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => TrainingAndCertificationBottomSheet(
        formKey: _formKey,
        trainingCertificationStream: trainingCertificationStream,
      ),
    );
  }

  void showAddTCWithDetailBottomModelSheet(TrainingCertification? tc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => TrainingAndCertificationBottomSheet(
        formKey: _formKey,
        trainingCertificationStream: trainingCertificationStream,
        trainingCertification: tc,
      ),
    );
  }
}

class TrainingAndCertificationBottomSheet extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ProfileTrainingCertificationStream trainingCertificationStream;
  final TrainingCertification? trainingCertification;

  const TrainingAndCertificationBottomSheet(
      {super.key,
      required this.formKey,
      required this.trainingCertificationStream,
      this.trainingCertification});

  @override
  State<TrainingAndCertificationBottomSheet> createState() =>
      _TrainingAndCertificationBottomSheetState();
}

class _TrainingAndCertificationBottomSheetState
    extends State<TrainingAndCertificationBottomSheet>
    with InputValidationMixin {
  @override
  void initState() {
    super.initState();
    if (widget.trainingCertification != null) {
      widget.trainingCertificationStream
          .fetchInitialCallBackWithDetail(widget.trainingCertification);
      setState(() {});
    } else {
      widget.trainingCertificationStream.fetchInitialCallBack();
    }
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      Navigator.pop(context);
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      AppAlerts.displaySnackBar(context,
          "Training And Certification Detail Updated Successfully", true);
    }
    if (state is AccountCrudFailed) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(
          context, "Training And Certification Detail Updated Failed", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor.white,
      width: context.deviceSize.width,
      height: context.deviceSize.height,
      padding: Dimensions.kPaddingAllMedium,
      child: BlocConsumer<AccountCrudBloc, AccountCrudState>(
        listener: accountListener,
        builder: (context, state) {
          return StreamBuilder<bool>(
              stream: widget.trainingCertificationStream.isLoading,
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
                            Text('Training And Certification Details',
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
                          label: "Course Name",
                          controller:
                              widget.trainingCertificationStream.courseName,
                          required: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!))
                              return "required *";
                            return null;
                          },
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        CustomTextFormField(
                          label: "Certificate Name",
                          controller: widget
                              .trainingCertificationStream.certificateName,
                          required: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!))
                              return "required *";
                            return null;
                          },
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        CustomStreamDropDownWidget(
                          label: "Certificate Level",
                          streamList: widget
                              .trainingCertificationStream.certificateLevel,
                          required: true,
                          initialData: widget.trainingCertification
                                  ?.certificateLevelName ??
                              '',
                          valueListInit: widget.trainingCertificationStream
                              .certificateLevelListInit,
                          onChanged: (val) {
                            if (val != '') {
                              widget.trainingCertificationStream
                                  .selectedCertificateLevel(val);
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
                          label: "Course Duration in (months)",
                          controller:
                              widget.trainingCertificationStream.courseDuration,
                          required: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!))
                              return "required *";
                            return null;
                          },
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        CustomDateTimeTextFormField(
                          label: "Issue Date",
                          required: true,
                          controller: TextEditingController(
                              text: widget.trainingCertificationStream
                                      .selectIssuedDate.valueOrNull ??
                                  ''),
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required *";
                            }
                            return null;
                          },
                          onPressed: () async {
                            DateTime date = await PickDateTime.date(context,
                                selectedDate: widget.trainingCertificationStream
                                    .issuedDate.valueOrNull,
                                startDate: null);
                            widget.trainingCertificationStream
                                .selectedIssuedDate(date);
                            // setState(() {});
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
                            stream: widget.trainingCertificationStream.file,
                            builder: (context, snapshot) {
                              final file = snapshot.data;
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: widget.trainingCertificationStream
                                        .selectedFile,
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
                                                  .trainingCertificationStream
                                                  .removeFile,
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
                        state is AccountCrudLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ActionButton(
                                onPressed: widget.trainingCertification != null
                                    ? () => widget.trainingCertificationStream
                                        .onUpdate(context,
                                            widget.trainingCertification!)
                                    : () => widget.trainingCertificationStream
                                        .onSubmit(context),
                                child: Text(
                                  widget.trainingCertification != null
                                      ? 'UPDATE'
                                      : 'SUBMIT',
                                  style: context.textTheme.labelLarge
                                      ?.copyWith(color: appColor.white),
                                ),
                              ),
                        Dimensions.kVerticalSpaceSmall,
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
