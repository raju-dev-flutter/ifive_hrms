import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdateExperienceScreen extends StatefulWidget {
  const ProfileUpdateExperienceScreen({super.key});

  @override
  State<ProfileUpdateExperienceScreen> createState() =>
      _ProfileUpdateExperienceScreenState();
}

class _ProfileUpdateExperienceScreenState
    extends State<ProfileUpdateExperienceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final experienceStream = sl<ProfileExperienceStream>();

  @override
  void initState() {
    super.initState();
    experienceStream.fetchInitialCallBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Experience Details",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddExperienceDetailBottomModelSheet,
        label: const Icon(Icons.add),
      ),
      body: _buildBodyUI(),
    );
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      // Navigator.pop(context);
      experienceStream.onClose();
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      // AppAlerts.displaySnackBar(
      //     context, "Experience Detail Delete Successfully", true);
    }
    if (state is AccountCrudFailed) {
      // Navigator.pop(context);
      // AppAlerts.displaySnackBar(
      //     context, "Experience Detail Delete Failed", false);
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
              final experienceList = state.profile.experience!;
              if (experienceList.isEmpty) {
                return Center(child: EmptyScreen(onPressed: () async {
                  BlocProvider.of<AccountDetailsCubit>(context)
                      .getAccountDetails();
                }));
              }
              return ListView.builder(
                  itemCount: experienceList.length,
                  itemBuilder: (_, i) {
                    return _$DraggableExperienceCardUI(experienceList[i], i);
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

  Widget _$DraggableExperienceCardUI(Experience experience, int index) {
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
                  showAddExperienceWithDetailBottomModelSheet(experience),
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
              onPressed: (_) => experienceStream.onDelete(context, experience),
              backgroundColor: appColor.error100,
              foregroundColor: appColor.error500,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.circular(8).w,
            ),
          ],
        ),
        child: _$ExperienceCardUI(experience),
      ),
    );
  }

  Widget _$ExperienceCardUI(Experience experience) {
    return InkWell(
      onDoubleTap: () =>
          showAddExperienceWithDetailBottomModelSheet(experience),
      child: Container(
        padding: Dimensions.kPaddingAllSmall,
        decoration: BoxDecoration(
          color: appColor.white,
          borderRadius: BorderRadius.circular(8).w,
          border: Border.all(color: appColor.blueDark100, width: 1),
          // border: Border(left: BorderSide(width: 5, color: appColor.blue600)),
          boxShadow: [
            BoxShadow(
              color: appColor.blueDark100.withOpacity(.2),
              blurRadius: 12,
              offset: const Offset(0, 3),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.achievement,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "${experience.designation ?? ""},\n"),
                        TextSpan(
                          text: "Designation",
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
              children: [
                SvgPicture.asset(
                  AppSvg.company,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: "${experience.organizationName ?? ""},\n"),
                        TextSpan(
                          text: "${experience.organizationWebsite ?? ""},\n",
                          style: context.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: "Organization | Website",
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
              children: [
                SvgPicture.asset(
                  AppSvg.wallet,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(text: "${experience.ctc ?? ""}\n"),
                        TextSpan(
                          text: "CTC",
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
              children: [
                SvgPicture.asset(
                  AppSvg.date,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                            text:
                                "${experience.fromDate ?? ""} to ${experience.toDate ?? ""} |  ${experience.experienceType ?? ""}Y\n"),
                        TextSpan(
                          text: "Experience Date | Experience Year",
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
              children: [
                SvgPicture.asset(
                  AppSvg.info,
                  width: Dimensions.iconSizeSmall,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark500, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.labelLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: "${experience.reasonLeaving ?? ""}\n",
                        ),
                        TextSpan(
                          text: "Leaving Reason",
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
      ),
    );
  }

  void showAddExperienceDetailBottomModelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => ExperienceFormBottomSheet(
          formKey: _formKey, experienceStream: experienceStream),
    );
  }

  void showAddExperienceWithDetailBottomModelSheet(Experience? e) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => ExperienceFormBottomSheet(
          formKey: _formKey, experienceStream: experienceStream, experience: e),
    );
  }
}

class ExperienceFormBottomSheet extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ProfileExperienceStream experienceStream;
  final Experience? experience;

  const ExperienceFormBottomSheet(
      {super.key,
      required this.formKey,
      required this.experienceStream,
      this.experience});

  @override
  State<ExperienceFormBottomSheet> createState() =>
      _ExperienceFormBottomSheetState();
}

class _ExperienceFormBottomSheetState extends State<ExperienceFormBottomSheet>
    with InputValidationMixin {
  @override
  void initState() {
    super.initState();
    if (widget.experience != null) {
      widget.experienceStream.fetchInitialCallBackWithDetail(widget.experience);
    } else {
      widget.experienceStream.fetchInitialCallBack();
    }
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      Navigator.pop(context);
      widget.experienceStream.onClose();
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      AppAlerts.displaySnackBar(
          context, "Experience Detail Delete Successfully", true);
    }
    if (state is AccountCrudFailed) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(
          context, "Experience Detail Delete Failed", false);
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
        child: SingleChildScrollView(
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
                    Text('Experience Details',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: appColor.brand800)),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          Icon(Icons.cancel_rounded, color: appColor.error600),
                    ),
                  ],
                ),
                Dimensions.kVerticalSpaceSmall,
                CustomTextFormField(
                  label: "Organization Name",
                  controller: widget.experienceStream.organizationName,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Organization Website",
                  controller: widget.experienceStream.organizationWebsite,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Designation",
                  controller: widget.experienceStream.designation,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "CTC",
                  controller: widget.experienceStream.ctc,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomDateTimeTextFormField(
                  label: "From",
                  required: true,
                  controller: TextEditingController(
                      text:
                          widget.experienceStream.selectFromDate.valueOrNull ??
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
                            widget.experienceStream.fromDate.valueOrNull,
                        startDate: null);
                    widget.experienceStream.selectedFromDate(date);
                    setState(() {});
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomDateTimeTextFormField(
                  label: "To",
                  required: true,
                  controller: TextEditingController(
                      text: widget.experienceStream.selectToDate.valueOrNull ??
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
                            widget.experienceStream.toDate.valueOrNull,
                        startDate: null);
                    widget.experienceStream.selectedToDate(date);
                    setState(() {});
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Experience years",
                  controller: TextEditingController(
                      text:
                          widget.experienceStream.experienceYears.valueOrNull ??
                              ''),
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Reason for Leaving",
                  controller: widget.experienceStream.reasonForLeaving,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
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
                    stream: widget.experienceStream.file,
                    builder: (context, snapshot) {
                      final file = snapshot.data;
                      return Row(
                        children: [
                          InkWell(
                            onTap: widget.experienceStream.selectedFile,
                            child: Stack(
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        Dimensions.kBorderRadiusAllSmallest,
                                    border:
                                        Border.all(color: appColor.brand600),
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
                                      onTap: widget.experienceStream.removeFile,
                                      child: Icon(Icons.change_circle_outlined,
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
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ActionButton(
                      onPressed: widget.experience != null
                          ? () => widget.experienceStream
                              .onUpdate(context, widget.experience!)
                          : () => widget.experienceStream.onSubmit(context),
                      child: Text(
                        widget.experience != null ? 'UPDATE' : 'SUBMIT',
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
        ),
      ),
    );
  }
}
