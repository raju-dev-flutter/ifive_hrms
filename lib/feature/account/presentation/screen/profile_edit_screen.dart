import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileEditScreen extends StatefulWidget {
  final Profile profile;

  const ProfileEditScreen({super.key, required this.profile});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final profileEdit = sl<ProfileEditStream>();

  @override
  void initState() {
    super.initState();
    profileEdit.fetchInitialCallBack(widget.profile);
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
          title: "Profile Edit",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      child: BlocConsumer<AccountCrudBloc, AccountCrudState>(
        listener: (context, state) {
          if (state is AccountCrudSuccess) {
            Navigator.pop(context);
            BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
            AppAlerts.displaySnackBar(
                context, "Profile Edited Successfully", true);
          }
          if (state is AccountCrudFailed) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(context, "Profile Edit Failed", false);
          }
        },
        builder: (context, state) {
          return Container(
            padding: Dimensions.kPaddingAllMedium,
            child: Column(
              children: [
                CustomTextFormField(
                  label: "First Name",
                  controller: profileEdit.firstName,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Last Name",
                  controller: profileEdit.lastName,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Mobile Number",
                  controller: profileEdit.phoneNumber,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Email",
                  controller: profileEdit.email,
                  required: true,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                // CustomStreamDropDownWidget(
                //   label: 'Blood Group',
                //   streamList: profileEdit.bloodGroupList,
                //   required: true,
                //   valueListInit: profileEdit.bloodGroupListInit,
                //   onChanged: (val) {
                //     if (val != '') profileEdit.bloodGroup(val);
                //     setState(() {});
                //     FocusScope.of(context).requestFocus(FocusNode());
                //   },
                //   validator: (val) {
                //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                //     return null;
                //   },
                // ),
                // Dimensions.kVerticalSpaceSmaller,
                CustomDateTimeTextFormField(
                  label: 'Date of Birth',
                  required: true,
                  controller: TextEditingController(
                      text: profileEdit.selectDateOfBirth.valueOrNull ?? ''),
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) {
                      return "required *";
                    }
                    return null;
                  },
                  onPressed: () async {
                    DateTime date = await PickDateTime.date(context,
                        selectedDate: profileEdit.dateOfBirth.valueOrNull,
                        startDate: null);
                    profileEdit.selectedDateOfBirth(date);
                    setState(() {});
                  },
                ),
                Dimensions.kVerticalSpaceLarge,
                state is AccountCrudLoading
                    ? const CircularProgressIndicator()
                    : ActionButton(
                        onPressed: () => profileEdit.onSubmit(context),
                        child: Text(
                          'UPDATE',
                          style: context.textTheme.labelLarge
                              ?.copyWith(color: appColor.white),
                        ),
                      ),
                Dimensions.kVerticalSpaceSmall,
              ],
            ),
          );
        },
      ),
    );
  }
}
