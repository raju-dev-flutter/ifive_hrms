import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdateSkillsScreen extends StatefulWidget {
  const ProfileUpdateSkillsScreen({super.key});

  @override
  State<ProfileUpdateSkillsScreen> createState() =>
      _ProfileUpdateSkillsScreenState();
}

class _ProfileUpdateSkillsScreenState extends State<ProfileUpdateSkillsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final skillsStream = sl<ProfileSkillsStream>();

  @override
  void initState() {
    super.initState();
    skillsStream.fetchInitialCallBack();
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
          title: "Skills Details",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddSkillDetailBottomModelSheet,
        label: const Icon(Icons.add),
      ),
      body: _buildBodyUI(),
    );
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      skillsStream.onClose();
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
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
            final skillList = state.profile.skills!;
            if (skillList.isEmpty) {
              return Center(child: EmptyScreen(onPressed: () async {
                BlocProvider.of<AccountDetailsCubit>(context)
                    .getAccountDetails();
              }));
            }
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<AccountDetailsCubit>(context)
                    .getAccountDetails();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: Dimensions.kPaddingAllMedium,
                itemCount: skillList.length,
                itemBuilder: (_, i) {
                  return _$DraggableExperienceCardUI(skillList[i], i);
                },
              ),
            );
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

  Widget _$DraggableExperienceCardUI(Skills skill, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Slidable(
        key: ValueKey(index),
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => showAddSkillWithDetailBottomModelSheet(skill),
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
              onPressed: (_) => skillsStream.onDelete(context, skill),
              backgroundColor: appColor.error100,
              foregroundColor: appColor.error500,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.circular(8).w,
            ),
          ],
        ),
        child: _$SkillCardUI(skill),
      ),
    );
  }

  Widget _$SkillCardUI(Skills skill) {
    return InkWell(
      onDoubleTap: () => showAddSkillWithDetailBottomModelSheet(skill),
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
                  AppSvg.achievement,
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
                        TextSpan(text: "${skill.skill ?? ""}\n"),
                        TextSpan(
                          text: "Skill",
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
                  AppSvg.infoOutline,
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
                        TextSpan(text: "${skill.version ?? ""}\n"),
                        TextSpan(
                          text: "Version",
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

  void showAddSkillDetailBottomModelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) =>
          SkillsFormBottomSheet(formKey: _formKey, skillsStream: skillsStream),
    );
  }

  void showAddSkillWithDetailBottomModelSheet(Skills skill) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => SkillsFormBottomSheet(
          formKey: _formKey, skillsStream: skillsStream, skill: skill),
    );
  }
}

class SkillsFormBottomSheet extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ProfileSkillsStream skillsStream;
  final Skills? skill;

  const SkillsFormBottomSheet(
      {super.key,
      required this.formKey,
      required this.skillsStream,
      this.skill});

  @override
  State<SkillsFormBottomSheet> createState() => _SkillsFormBottomSheetState();
}

class _SkillsFormBottomSheetState extends State<SkillsFormBottomSheet>
    with InputValidationMixin {
  @override
  void initState() {
    super.initState();
    if (widget.skill != null) {
      widget.skillsStream.fetchInitialCallBackWithDetail(widget.skill);
    } else {
      widget.skillsStream.fetchInitialCallBack();
    }
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      Navigator.pop(context);
      widget.skillsStream.onClose();
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      AppAlerts.displaySnackBar(
          context, "Skills Detail Updated Successfully", true);
    }
    if (state is AccountCrudFailed) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(context, "Skills Detail Updated Failed", false);
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
            stream: widget.skillsStream.isLoading,
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
                          Text('Skills Details',
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
                        label: "Skill",
                        controller: widget.skillsStream.skill,
                        required: true,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomTextFormField(
                        label: "Version",
                        controller: widget.skillsStream.version,
                        required: true,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomStreamDropDownWidget(
                        label: "Competency Level",
                        streamList: widget.skillsStream.competencyLevel,
                        required: true,
                        initialData: widget.skill?.competencyLevelName ?? '',
                        valueListInit:
                            widget.skillsStream.competencyLevelListInit,
                        onChanged: (val) {
                          if (val != '') {
                            widget.skillsStream.selectedCompetencyLevel(val);
                          }
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
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
                          stream: widget.skillsStream.file,
                          builder: (context, snapshot) {
                            final file = snapshot.data;
                            return Row(
                              children: [
                                InkWell(
                                  onTap: widget.skillsStream.selectedFile,
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
                                            onTap:
                                                widget.skillsStream.removeFile,
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
                            onPressed: widget.skill != null
                                ? () => widget.skillsStream
                                    .onUpdate(context, widget.skill!)
                                : () => widget.skillsStream.onSubmit(context),
                            child: Text(
                              widget.skill != null ? 'UPDATE' : 'SUBMIT',
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
