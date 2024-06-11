import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdatePersonalScreen extends StatefulWidget {
  final Personal? personal;
  const ProfileUpdatePersonalScreen({super.key, this.personal});

  @override
  State<ProfileUpdatePersonalScreen> createState() =>
      _ProfileUpdatePersonalScreenState();
}

class _ProfileUpdatePersonalScreenState
    extends State<ProfileUpdatePersonalScreen> with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, TextEditingController>> multiTextController = [];

  final personalStream = sl<ProfilePersonalStream>();

  @override
  void initState() {
    super.initState();
    if (widget.personal != null) {
      personalStream.fetchInitialCallBackWithDetail(widget.personal);
      initiateMultiController();
    } else {
      personalStream.fetchInitialCallBack();
    }
  }

  void initiateMultiController() {
    final language = widget.personal!.language;
    List<dynamic> jsonDecodeContact = jsonDecode(language!);
    for (var language in jsonDecodeContact) {
      setState(() {
        multiTextController.add({
          'language': TextEditingController(text: language[0]),
          'read': TextEditingController(text: language[1]),
          'write': TextEditingController(text: language[2]),
          'speak': TextEditingController(text: language[3]),
        });
      });
    }
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
          title: "Personal Details",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  void accountListener(BuildContext context, AccountCrudState state) {
    if (state is AccountCrudSuccess) {
      Navigator.pop(context);
      BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
      AppAlerts.displaySnackBar(
          context, "Personal Detail Updated Successfully", true);
    }
    if (state is AccountCrudFailed) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(
          context, "Personal Detail Updated Failed", false);
    }
  }

  _buildBodyUI() {
    return SingleChildScrollView(
      child: BlocConsumer<AccountCrudBloc, AccountCrudState>(
        listener: accountListener,
        builder: (context, state) {
          return StreamBuilder<bool>(
              stream: personalStream.isLoading,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return Container(
                    height: context.deviceSize.height,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      personalDetailFormCard(),
                      Dimensions.kVerticalSpaceSmaller,
                      additionalDetailFormCard(),
                      Dimensions.kVerticalSpaceSmaller,
                      languageDetailFormCard(),
                      Dimensions.kVerticalSpaceSmaller,
                      familyDetailFormCard(),
                      Dimensions.kVerticalSpaceSmaller,
                      state is AccountCrudLoading
                          ? const CircularProgressIndicator()
                          : Container(
                              padding: Dimensions.kPaddingAllMedium,
                              color: appColor.white,
                              child: ActionButton(
                                onPressed: widget.personal != null
                                    ? () => personalStream.onUpdate(context,
                                        widget.personal!, multiTextController)
                                    : () => personalStream.onSubmit(
                                        context, multiTextController),
                                child: Text(
                                  widget.personal != null ? 'UPDATE' : 'SUBMIT',
                                  style: context.textTheme.labelLarge
                                      ?.copyWith(color: appColor.white),
                                ),
                              ),
                            ),
                      // Dimensions.kVerticalSpaceSmall,
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget personalDetailFormCard() {
    return Container(
      width: context.deviceSize.width,
      padding: Dimensions.kPaddingAllMedium,
      color: appColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: appColor.brand800)),
          Dimensions.kVerticalSpaceSmall,
          CustomStreamDropDownWidget(
            label: "Gender",
            streamList: personalStream.gender,
            required: true,
            valueListInit: personalStream.genderListInit,
            onChanged: (val) {
              if (val != '') personalStream.selectedGender(val);
              setState(() {});
              FocusScope.of(context).requestFocus(FocusNode());
            },
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomStreamDropDownWidget(
            label: "Marital Status",
            streamList: personalStream.maritalStatus,
            required: true,
            valueListInit: personalStream.maritalStatusListInit,
            onChanged: (val) {
              if (val != '') personalStream.selectedMaritalStatus(val);
              setState(() {});
              FocusScope.of(context).requestFocus(FocusNode());
            },
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomStreamDropDownWidget(
            label: "Nationality",
            streamList: personalStream.nationality,
            required: true,
            valueListInit: personalStream.nationalityListInit,
            onChanged: (val) {
              if (val != '') personalStream.selectedNationality(val);
              setState(() {});
              FocusScope.of(context).requestFocus(FocusNode());
            },
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomDateTimeTextFormField(
            label: 'Date of Birth',
            required: true,
            controller: TextEditingController(
                text: personalStream.selectDob.valueOrNull ?? ''),
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
            onPressed: () async {
              DateTime date = await PickDateTime.date(context,
                  selectedDate: personalStream.dob.valueOrNull,
                  startDate: null);
              personalStream.selectedDob(date);
              setState(() {});
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Age",
            controller: TextEditingController(
                text: personalStream.age.valueOrNull ?? ''),
            required: true,
            readOnly: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget additionalDetailFormCard() {
    return Container(
      width: context.deviceSize.width,
      padding: Dimensions.kPaddingAllMedium,
      color: appColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Additional Information',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: appColor.brand800)),
          Dimensions.kVerticalSpaceSmall,
          CustomStreamDropDownWidget(
            label: "Blood Group",
            streamList: personalStream.bloodGroup,
            required: true,
            valueListInit: personalStream.bloodGroupListInit,
            onChanged: (val) {
              if (val != '') personalStream.selectedBloodGroup(val);
              setState(() {});
              FocusScope.of(context).requestFocus(FocusNode());
            },
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Personal Mail ID",
            controller: personalStream.personalMail,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Personal Contact",
            controller: personalStream.personalContact,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomStreamDropDownWidget(
            label: "Mother Tongue",
            streamList: personalStream.motherTongue,
            required: true,
            initialData: widget.personal?.motherTongueName ?? '',
            valueListInit: personalStream.motherTongueListInit,
            onChanged: (val) {
              if (val != '') personalStream.selectedMotherTongue(val);
              setState(() {});
              FocusScope.of(context).requestFocus(FocusNode());
            },
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget familyDetailFormCard() {
    return Container(
      width: context.deviceSize.width,
      padding: Dimensions.kPaddingAllMedium,
      color: appColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Family Information',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: appColor.brand800)),
          Dimensions.kVerticalSpaceSmall,
          CustomTextFormField(
            label: "Father Name",
            controller: personalStream.fatherName,
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Father Aadhaar Number",
            controller: personalStream.fatherAadhaarNumber,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomDateTimeTextFormField(
            label: 'Father DOB',
            required: true,
            controller: TextEditingController(
                text: personalStream.selectFatherDob.valueOrNull ?? ''),
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
            onPressed: () async {
              DateTime date = await PickDateTime.date(context,
                  selectedDate: personalStream.fatherDob.valueOrNull,
                  startDate: null);
              personalStream.selectedFatherDob(date);
              setState(() {});
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Father Age",
            controller: TextEditingController(
                text: personalStream.fatherAge.valueOrNull ?? ''),
            required: true,
            readOnly: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Mother Name",
            controller: personalStream.motherName,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Mother Aadhaar Number",
            controller: personalStream.motherAadhaarNumber,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomDateTimeTextFormField(
            label: 'Mother DOB',
            required: true,
            controller: TextEditingController(
                text: personalStream.selectMotherDob.valueOrNull ?? ''),
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
            onPressed: () async {
              DateTime date = await PickDateTime.date(context,
                  selectedDate: personalStream.motherDob.valueOrNull,
                  startDate: null);
              personalStream.selectedMotherDob(date);
              setState(() {});
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Mother Age",
            controller: TextEditingController(
                text: personalStream.motherAge.valueOrNull ?? ''),
            required: true,
            readOnly: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget languageDetailFormCard() {
    return Container(
      width: context.deviceSize.width,
      color: appColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 2)
                    .w,
            child: Text('Language',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500, color: appColor.brand800)),
          ),
          for (var i = 0; i < multiTextController.length; i++)
            languageDetailTextField(
                controller: multiTextController[i], position: i),
          Dimensions.kVerticalSpaceMedium,
          languageDetailButton(onTap: () {
            setState(() {
              multiTextController.add({
                'language': TextEditingController(text: ""),
                'read': TextEditingController(text: ""),
                'write': TextEditingController(text: ""),
                'speak': TextEditingController(text: ""),
              });
            });
          }),
          Dimensions.kVerticalSpaceSmall,
        ],
      ),
    );
  }

  languageDetailTextField(
      {required Map<String, TextEditingController> controller,
      required int position}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16).w,
            child: DottedBorder(
              color: appColor.gray200,
              borderType: BorderType.RRect,
              radius: const Radius.circular(8).w,
              strokeWidth: 1,
              dashPattern: const [3],
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16).w,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: "Name",
                    controller: controller['language']!,
                    required: false,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: controller['read']!.text == "read"
                                ? true
                                : false,
                            onChanged: (val) {
                              if (controller['read']!.text == "read") {
                                setState(() {
                                  controller['read'] =
                                      TextEditingController(text: "");
                                });
                              } else {
                                setState(() {
                                  controller['read'] =
                                      TextEditingController(text: "read");
                                });
                              }
                            },
                          ),
                          Text(
                            "read",
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: appColor.gray600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller['write']!.text == "write"
                                ? true
                                : false,
                            onChanged: (val) {
                              if (controller['write']!.text == "write") {
                                setState(() {
                                  controller['write'] =
                                      TextEditingController(text: "");
                                });
                              } else {
                                setState(() {
                                  controller['write'] =
                                      TextEditingController(text: "write");
                                });
                              }
                            },
                          ),
                          Text(
                            "write",
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: appColor.gray600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller['speak']!.text == "speak"
                                ? true
                                : false,
                            onChanged: (val) {
                              if (controller['speak']!.text == "speak") {
                                setState(() {
                                  controller['speak'] =
                                      TextEditingController(text: "");
                                });
                              } else {
                                setState(() {
                                  controller['speak'] =
                                      TextEditingController(text: "speak");
                                });
                              }
                            },
                          ),
                          Text(
                            "speak",
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: appColor.gray600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 10,
            child: InkWell(
              borderRadius: BorderRadius.circular(20).w,
              onTap: () {
                for (var i = 0; i < multiTextController.length; i++) {
                  if (position == i) {
                    setState(() => multiTextController.removeAt(i));
                    break;
                  }
                }
              },
              child: Container(
                width: 25.w,
                height: 25.h,
                padding: Dimensions.kPaddingAllSmaller,
                decoration: BoxDecoration(
                  color: appColor.error50,
                  borderRadius: Dimensions.kBorderRadiusAllMedium,
                ),
                child: SvgPicture.asset(
                  AppSvg.cancel,
                  width: 12.w,
                  colorFilter:
                      ColorFilter.mode(appColor.error600, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  languageDetailButton({required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: InkWell(
        onTap: onTap,
        child: DottedBorder(
          color: appColor.blue600,
          borderType: BorderType.RRect,
          radius: const Radius.circular(8).w,
          strokeWidth: 1,
          dashPattern: const [3],
          child: Container(
            height: 42.h,
            alignment: Alignment.center,
            child: Text(
              'Add Language',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1, color: appColor.blue600),
            ),
          ),
        ),
      ),
    );
  }
}
