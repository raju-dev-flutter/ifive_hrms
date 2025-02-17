import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdateVisaImmigrationScreen extends StatefulWidget {
  const ProfileUpdateVisaImmigrationScreen({super.key});

  @override
  State<ProfileUpdateVisaImmigrationScreen> createState() =>
      _ProfileUpdateVisaImmigrationScreenState();
}

class _ProfileUpdateVisaImmigrationScreenState
    extends State<ProfileUpdateVisaImmigrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final visaImmigrationStream = sl<ProfileVisaImmigrationStream>();

  @override
  void initState() {
    super.initState();
    visaImmigrationStream.fetchInitialCallBack();
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
          title: "Visa and Immigration Details",
          centerTitle: true,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddVIDetailBottomModelSheet,
        label: const Icon(Icons.add),
      ),
      body: _buildBodyUI(),
    );
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      visaImmigrationStream.onClose();
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
          if (state is AccountDetailsFailed) {
            return Center(child: EmptyScreen(onPressed: () async {
              BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
            }));
          }
          if (state is AccountDetailsLoaded) {
            final visaImmigration = state.profile.visaImmigration!;
            if (visaImmigration.isEmpty) {
              return Center(child: EmptyScreen(onPressed: () async {
                BlocProvider.of<AccountDetailsCubit>(context)
                    .getAccountDetails();
              }));
            }
            return ListView.builder(
                padding: Dimensions.kPaddingAllMedium,
                itemCount: visaImmigration.length,
                itemBuilder: (_, i) {
                  return _$DraggableVisaAndImmigrationCardUI(
                      visaImmigration[i], i);
                });
          }
          return Container();
        },
      ),
    );
  }

  Widget _$DraggableVisaAndImmigrationCardUI(VisaImmigration vi, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Slidable(
        key: ValueKey(index),
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => showAddVIWithDetailBottomModelSheet(vi),
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
              onPressed: (_) => visaImmigrationStream.onDelete(context, vi),
              backgroundColor: appColor.error100,
              foregroundColor: appColor.error500,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.circular(8).w,
            ),
          ],
        ),
        child: _$VisaAndImmigrationCardUI(vi),
      ),
    );
  }

  Widget _$VisaAndImmigrationCardUI(VisaImmigration vi) {
    return InkWell(
      onDoubleTap: () => showAddVIWithDetailBottomModelSheet(vi),
      child: Container(
        padding: Dimensions.kPaddingAllSmall,
        decoration: BoxDecoration(
          color: appColor.white,
          borderRadius: BorderRadius.circular(8).w,
          border: Border.all(color: appColor.blueDark600, width: 1),
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
                  AppSvg.passport,
                  width: Dimensions.iconSizeSmaller,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark600, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "${vi.passportNumber ?? ""}\n"),
                        TextSpan(
                          text: "Passport Number",
                          style: context.textTheme.labelMedium,
                        ),
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
                  width: Dimensions.iconSizeSmaller,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark600, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text:
                                "${vi.passportIssuedDate ?? ""} to ${vi.passportExpiryDate ?? ""}\n"),
                        TextSpan(
                          text: "Passport Issue | Expiry Date",
                          style: context.textTheme.labelMedium,
                        ),
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
                  AppSvg.passport,
                  width: Dimensions.iconSizeSmaller,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark600, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "${vi.visaNumber ?? ""}\n"),
                        TextSpan(
                          text: "Visa Number",
                          style: context.textTheme.labelMedium,
                        ),
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
                  width: Dimensions.iconSizeSmaller,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark600, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text:
                                "${vi.visaIssuedDate ?? ""} to ${vi.visaExpiryDate ?? ""}\n"),
                        TextSpan(
                          text: "Visa Issue | Expiry Date",
                          style: context.textTheme.labelMedium,
                        ),
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
                  AppSvg.location,
                  width: Dimensions.iconSizeSmaller,
                  colorFilter:
                      ColorFilter.mode(appColor.blueDark600, BlendMode.srcIn),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "${vi.visaCountryName ?? ""}\n"),
                        TextSpan(
                          text: "Country",
                          style: context.textTheme.labelMedium,
                        ),
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

  void showAddVIDetailBottomModelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => VisaImmigrationFormBottomSheet(
          formKey: _formKey, visaImmigrationStream: visaImmigrationStream),
    );
  }

  void showAddVIWithDetailBottomModelSheet(VisaImmigration vi) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => VisaImmigrationFormBottomSheet(
          formKey: _formKey,
          visaImmigrationStream: visaImmigrationStream,
          visaImmigration: vi),
    );
  }
}

class VisaImmigrationFormBottomSheet extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ProfileVisaImmigrationStream visaImmigrationStream;
  final VisaImmigration? visaImmigration;

  const VisaImmigrationFormBottomSheet(
      {super.key,
      required this.formKey,
      required this.visaImmigrationStream,
      this.visaImmigration});

  @override
  State<VisaImmigrationFormBottomSheet> createState() =>
      _VisaImmigrationFormBottomSheetState();
}

class _VisaImmigrationFormBottomSheetState
    extends State<VisaImmigrationFormBottomSheet> with InputValidationMixin {
  @override
  void initState() {
    super.initState();
    if (widget.visaImmigration != null) {
      widget.visaImmigrationStream
          .fetchInitialCallBackWithDetail(widget.visaImmigration);
      setState(() {});
    } else {
      widget.visaImmigrationStream.fetchInitialCallBack();
    }
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      Navigator.pop(context);
      widget.visaImmigrationStream.onClose();
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      AppAlerts.displaySnackBar(
          context, "Visa and Immigration Detail Updated Successfully", true);
    }
    if (state is AccountCrudFailed) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(
          context, "Visa and Immigration Detail Updated Failed", false);
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
            stream: widget.visaImmigrationStream.isLoading,
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
                          Text('Visa and Immigration Details',
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
                        label: "Passport Number",
                        hint: "Passport Number",
                        controller: widget.visaImmigrationStream.passportNumber,
                        required: true,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomDateTimeTextFormField(
                        label: 'Passport Issued Date',
                        required: true,
                        controller: TextEditingController(
                            text: widget.visaImmigrationStream
                                    .selectPassportIssuedDate.valueOrNull ??
                                ''),
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!)) {
                            return "required *";
                          }
                          return null;
                        },
                        onPressed: () async {
                          DateTime date = await PickDateTime.date(context,
                              selectedDate: widget.visaImmigrationStream
                                  .passportIssuedDate.valueOrNull,
                              startDate: null);
                          widget.visaImmigrationStream
                              .selectedPassportIssuedDate(date);
                          // setState(() {});
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomDateTimeTextFormField(
                        label: 'Passport Expiry Date',
                        required: true,
                        controller: TextEditingController(
                            text: widget.visaImmigrationStream
                                    .selectPassportExpiryDate.valueOrNull ??
                                ''),
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!)) {
                            return "required *";
                          }
                          return null;
                        },
                        onPressed: () async {
                          DateTime date = await PickDateTime.date(context,
                              selectedDate: widget.visaImmigrationStream
                                  .passportExpiryDate.valueOrNull,
                              startDate: null);
                          widget.visaImmigrationStream
                              .selectedPassportExpiryDate(date);
                          // setState(() {});
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomTextFormField(
                        label: "Visa Type Code",
                        hint: "Visa Type Code",
                        controller: widget.visaImmigrationStream.visaTypeCode,
                        required: false,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomTextFormField(
                        label: "Visa Number",
                        hint: "Visa Number",
                        controller: widget.visaImmigrationStream.visaNumber,
                        required: false,
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!))
                            return "required *";
                          return null;
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomStreamDropDownWidget(
                        label: "Visa Country",
                        streamList: widget.visaImmigrationStream.visaCountry,
                        required: true,
                        valueListInit:
                            widget.visaImmigrationStream.visaCountryListInit,
                        onChanged: (val) {
                          if (val != '')
                            widget.visaImmigrationStream
                                .selectedVisaCountry(val);
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
                      CustomDateTimeTextFormField(
                        label: 'Visa Issued Date',
                        required: true,
                        controller: TextEditingController(
                            text: widget.visaImmigrationStream
                                    .selectVisaIssuedDate.valueOrNull ??
                                ''),
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!)) {
                            return "required *";
                          }
                          return null;
                        },
                        onPressed: () async {
                          DateTime date = await PickDateTime.date(context,
                              selectedDate: widget.visaImmigrationStream
                                  .visaIssuedDate.valueOrNull,
                              startDate: null);
                          widget.visaImmigrationStream
                              .selectedVisaIssuedDate(date);
                          // setState(() {});
                        },
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      CustomDateTimeTextFormField(
                        label: 'Visa Expiry Date',
                        required: true,
                        controller: TextEditingController(
                            text: widget.visaImmigrationStream
                                    .selectVisaExpiryDate.valueOrNull ??
                                ''),
                        validator: (val) {
                          if (!isCheckTextFieldIsEmpty(val!)) {
                            return "required *";
                          }
                          return null;
                        },
                        onPressed: () async {
                          DateTime date = await PickDateTime.date(context,
                              selectedDate: widget.visaImmigrationStream
                                  .visaExpiryDate.valueOrNull,
                              startDate: null);
                          widget.visaImmigrationStream
                              .selectedVisaExpiryDate(date);
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
                          stream: widget.visaImmigrationStream.file,
                          builder: (context, snapshot) {
                            final file = snapshot.data;
                            return Row(
                              children: [
                                InkWell(
                                  onTap:
                                      widget.visaImmigrationStream.selectedFile,
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
                                            onTap: widget.visaImmigrationStream
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
                      BlocBuilder<AccountCrudBloc, AccountCrudState>(
                        builder: (context, state) {
                          if (state is AccountCrudLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ActionButton(
                            onPressed: widget.visaImmigration != null
                                ? () => widget.visaImmigrationStream
                                    .onUpdate(context, widget.visaImmigration!)
                                : () => widget.visaImmigrationStream
                                    .onSubmit(context),
                            child: Text(
                              widget.visaImmigration != null
                                  ? 'UPDATE'
                                  : 'SUBMIT',
                              //     () =>
                              //     widget.visaImmigrationStream.onSubmit(context),
                              // child: Text(
                              //   'SUBMIT',
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
