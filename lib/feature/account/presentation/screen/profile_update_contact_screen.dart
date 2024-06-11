import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdateContactScreen extends StatefulWidget {
  final Contact? contact;
  const ProfileUpdateContactScreen({super.key, this.contact});

  @override
  State<ProfileUpdateContactScreen> createState() =>
      _ProfileUpdateContactScreenState();
}

class _ProfileUpdateContactScreenState extends State<ProfileUpdateContactScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, TextEditingController>> multiTextController = [];

  final contactStream = sl<ProfileContactStream>();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      contactStream.fetchInitialCallBackWithDetail(widget.contact);
      initiateMultiController();
    } else {
      contactStream.fetchInitialCallBack();
    }
  }

  void initiateMultiController() {
    final emergencyContact = widget.contact!.emergencyContacts;
    List<dynamic> jsonDecodeContact = jsonDecode(emergencyContact!);
    for (var contact in jsonDecodeContact) {
      setState(() {
        multiTextController.add({
          'emergency_name': TextEditingController(text: contact[0]),
          'emergency_relation_type': TextEditingController(text: contact[1]),
          'emergency_contact_number': TextEditingController(text: contact[3]),
          'emergency_address': TextEditingController(text: contact[2]),
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
          title: "Contact Details",
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
          context, "Office Detail Updated Successfully", true);
    }
    if (state is AccountCrudFailed) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(context, "Office Detail Updated Failed", false);
    }
  }

  _buildBodyUI() {
    return SingleChildScrollView(
      child: BlocConsumer<AccountCrudBloc, AccountCrudState>(
        listener: accountListener,
        builder: (context, state) {
          return StreamBuilder<bool>(
              stream: contactStream.isLoading,
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
                      permanentDetailFormCard(),
                      Dimensions.kVerticalSpaceSmaller,
                      currentDetailFormCard(),
                      Dimensions.kVerticalSpaceSmaller,
                      emergencyDetailFormCard(),
                      Dimensions.kVerticalSpaceSmaller,
                      state is AccountCrudLoading
                          ? const CircularProgressIndicator()
                          : Container(
                              padding: Dimensions.kPaddingAllMedium,
                              color: appColor.white,
                              child: ActionButton(
                                onPressed: widget.contact != null
                                    ? () => contactStream.onUpdate(context,
                                        widget.contact!, multiTextController)
                                    : () => contactStream.onSubmit(
                                        context, multiTextController),
                                child: Text(
                                  widget.contact != null ? 'UPDATE' : 'SUBMIT',
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

  Widget permanentDetailFormCard() {
    return Container(
      width: context.deviceSize.width,
      padding: Dimensions.kPaddingAllMedium,
      color: appColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Permanent Address Details',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: appColor.brand800)),
          Dimensions.kVerticalSpaceSmall,
          CustomTextFormField(
            label: "Street",
            controller: contactStream.permanentStreet,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Address",
            controller: contactStream.permanentAddress,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Flat No",
            controller: contactStream.permanentFlatNo,
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomStreamDropDownWidget(
            label: "Country",
            streamList: contactStream.permanentCountry,
            required: true,
            valueListInit: contactStream.permanentCountryListInit,
            onChanged: (val) {
              if (val != '') contactStream.selectedPermanentCountry(val);
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
            label: "State",
            streamList: contactStream.permanentState,
            required: true,
            valueListInit: contactStream.permanentStateListInit,
            onChanged: (val) {
              if (val != '') contactStream.selectedPermanentState(val);
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
            label: "City",
            streamList: contactStream.permanentCity,
            required: true,
            valueListInit: contactStream.permanentCityListInit,
            onChanged: (val) {
              if (val != '') contactStream.selectedPermanentCity(val);
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
            label: "Pincode",
            controller: contactStream.permanentPinCode,
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Locality",
            controller: contactStream.permanentLocality,
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget currentDetailFormCard() {
    return StreamBuilder<bool>(
        stream: contactStream.sameAddress,
        builder: (context, snapshot) {
          final isSame = snapshot.data ?? false;
          if (isSame) {
            return Container(
              width: context.deviceSize.width,
              padding: Dimensions.kPaddingAllMedium,
              color: appColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Current Address Details',
                          style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: appColor.brand800)),
                      Dimensions.kSpacer,
                      Row(
                        children: [
                          StreamBuilder<bool>(
                              stream: contactStream.sameAddress,
                              builder: (context, snapshot) {
                                final isSame = snapshot.data ?? false;
                                return Checkbox(
                                    value: isSame,
                                    splashRadius: 2,
                                    onChanged: (val) {
                                      contactStream.isSameAddress(val!);
                                      setState(() {});
                                    });
                              }),
                          Text('Same Address',
                              style: context.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: appColor.brand800)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container(
            width: context.deviceSize.width,
            padding: Dimensions.kPaddingAllMedium,
            color: appColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Current Address Details',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: appColor.brand800)),
                    Dimensions.kSpacer,
                    Row(
                      children: [
                        StreamBuilder<bool>(
                            stream: contactStream.sameAddress,
                            builder: (context, snapshot) {
                              final isSame = snapshot.data ?? false;
                              return Checkbox(
                                  value: isSame,
                                  splashRadius: 2,
                                  onChanged: (val) {
                                    contactStream.isSameAddress(val!);
                                    setState(() {});
                                  });
                            }),
                        Text('Same Address',
                            style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: appColor.brand800)),
                      ],
                    ),
                  ],
                ),
                Dimensions.kVerticalSpaceSmall,
                CustomTextFormField(
                  label: "Street",
                  controller: contactStream.currentStreet,
                  required: false,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Address",
                  controller: contactStream.currentAddress,
                  required: false,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Flat No",
                  controller: contactStream.currentFlatNo,
                  required: false,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomStreamDropDownWidget(
                  label: "Country",
                  streamList: contactStream.currentCountry,
                  required: true,
                  valueListInit: contactStream.currentCountryListInit,
                  onChanged: (val) {
                    if (val != '') contactStream.selectedCurrentCountry(val);
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
                  label: "State",
                  streamList: contactStream.currentState,
                  required: true,
                  valueListInit: contactStream.currentStateListInit,
                  onChanged: (val) {
                    if (val != '') contactStream.selectedCurrentState(val);
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
                  label: "City",
                  streamList: contactStream.currentCity,
                  required: true,
                  valueListInit: contactStream.currentCityListInit,
                  onChanged: (val) {
                    if (val != '') contactStream.selectedCurrentCity(val);
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
                  label: "Pincode",
                  controller: contactStream.currentPinCode,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Locality",
                  controller: contactStream.currentLocality,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget emergencyDetailFormCard() {
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
            child: Text('Emergency Details',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500, color: appColor.brand800)),
          ),
          for (var i = 0; i < multiTextController.length; i++)
            emergencyDetailTextField(
                controller: multiTextController[i], position: i),
          Dimensions.kVerticalSpaceMedium,
          emergencyDetailButton(onTap: () {
            setState(() {
              multiTextController.add({
                'emergency_name': TextEditingController(text: ""),
                'emergency_relation_type': TextEditingController(text: ""),
                'emergency_contact_number': TextEditingController(text: ""),
                'emergency_address': TextEditingController(text: ""),
              });
            });
          }),
          Dimensions.kVerticalSpaceSmall,
        ],
      ),
    );
  }

  emergencyDetailTextField(
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
                    controller: controller['emergency_name']!,
                    required: false,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Relation Type",
                    controller: controller['emergency_relation_type']!,
                    required: false,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Contact Number",
                    controller: controller['emergency_contact_number']!,
                    required: false,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Address",
                    controller: controller['emergency_address']!,
                    required: false,
                    maxLines: 3,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
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

  emergencyDetailButton({required Function() onTap}) {
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
              'Add Emergency Contact',
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
