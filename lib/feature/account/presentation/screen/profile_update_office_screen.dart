import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdateOfficeScreen extends StatefulWidget {
  const ProfileUpdateOfficeScreen({super.key});

  @override
  State<ProfileUpdateOfficeScreen> createState() =>
      _ProfileUpdateOfficeScreenState();
}

class _ProfileUpdateOfficeScreenState extends State<ProfileUpdateOfficeScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Office Details",
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
          return Form(
            key: _formKey,
            child: Column(
              children: [
                employeeDetailFormCard(),
                Dimensions.kVerticalSpaceSmaller,
                otherDetailFormCard(),
                Dimensions.kVerticalSpaceSmaller,

                state is AccountCrudLoading
                    ? const CircularProgressIndicator()
                    : Container(
                        padding: Dimensions.kPaddingAllMedium,
                        color: appColor.white,
                        child: ActionButton(
                          onPressed: () {},
                          child: Text(
                            'SUBMIT',
                            style: context.textTheme.labelLarge
                                ?.copyWith(color: appColor.white),
                          ),
                        ),
                      ),
                // Dimensions.kVerticalSpaceSmall,
              ],
            ),
          );
        },
      ),
    );
  }

  employeeDetailFormCard() {
    return Container(
      width: context.deviceSize.width,
      padding: Dimensions.kPaddingAllMedium,
      color: appColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employee Details',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: appColor.brand800)),
          Dimensions.kVerticalSpaceSmall,
          CustomTextFormField(
            label: "Employee Code",
            controller: TextEditingController(),
            required: true,
            readOnly: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Prefix",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          // CustomStreamDropDownWidget(
          //   label: 'Prefix',
          //   streamList: []<Stream<List<CommonList>>>,
          //   required: true,
          //   // valueListInit: profileEdit.bloodGroupListInit,
          //   onChanged: (val) {
          //     // if (val != '') profileEdit.bloodGroup(val);
          //     setState(() {});
          //     FocusScope.of(context).requestFocus(FocusNode());
          //   },
          //   validator: (val) {
          //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
          //     return null;
          //   },
          // ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "First Name",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Last Name",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Email",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Company",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Location Name",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Department",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Reporting Manager",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Reporting Manager1",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Area",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Casual Leave",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Sick Leave",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
        ],
      ),
    );
  }

  otherDetailFormCard() {
    return Container(
      width: context.deviceSize.width,
      padding: Dimensions.kPaddingAllMedium,
      color: appColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Other Details',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: appColor.brand800)),
          Dimensions.kVerticalSpaceSmall,
          CustomTextFormField(
            label: "Position",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Grade",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomDateTimeTextFormField(
            label: 'Date Of Joining',
            required: true,
            controller: TextEditingController(),
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) {
                return "required *";
              }
              return null;
            },
            onPressed: () async {
              DateTime date = await PickDateTime.date(context,
                  selectedDate: null, startDate: null);
              setState(() {});
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "ESI Number",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "ESI Dispensary",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "PF Date",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Provident Fund Number",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "UAN Number",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Mobile Number",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Alternative Number",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Biometric Emp No",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Employee type",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Group Type",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Active",
            controller: TextEditingController(),
            required: true,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "OT Formula",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Category",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
          Dimensions.kVerticalSpaceSmaller,
          CustomTextFormField(
            label: "Earn Leave",
            controller: TextEditingController(),
            required: false,
            validator: (val) {
              if (!isCheckTextFieldIsEmpty(val!)) return "required *";
              return null;
            },
          ),
        ],
      ),
    );
  }
}
