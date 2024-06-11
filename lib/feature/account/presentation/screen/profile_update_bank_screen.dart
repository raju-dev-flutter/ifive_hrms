import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileUpdateBankScreen extends StatefulWidget {
  const ProfileUpdateBankScreen({super.key});

  @override
  State<ProfileUpdateBankScreen> createState() =>
      _ProfileUpdateBankScreenState();
}

class _ProfileUpdateBankScreenState extends State<ProfileUpdateBankScreen>
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
          title: "Bank Details",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddBackDetailBottomModelSheet,
        label: const Icon(Icons.add),
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
          return Container();
        },
      ),
    );
  }

  void showAddBackDetailBottomModelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (_) => BankFromBottomSheet(formKey: _formKey),
    );
  }
}

class BankFromBottomSheet extends StatelessWidget with InputValidationMixin {
  final GlobalKey<FormState> formKey;

  const BankFromBottomSheet({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor.white,
      width: context.deviceSize.width,
      height: context.deviceSize.height,
      padding: Dimensions.kPaddingAllMedium,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kVerticalSpaceLargest,
              Dimensions.kVerticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bank Details',
                      style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: appColor.brand800)),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel_rounded, color: appColor.error600),
                  ),
                ],
              ),
              Dimensions.kVerticalSpaceSmall,
              CustomTextFormField(
                label: "Bank Name",
                controller: TextEditingController(),
                required: true,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceSmaller,
              CustomTextFormField(
                label: "Branch Name",
                controller: TextEditingController(),
                required: true,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceSmaller,
              CustomTextFormField(
                label: "Account Type",
                controller: TextEditingController(),
                required: true,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceSmaller,
              CustomTextFormField(
                label: "IFSC Code",
                controller: TextEditingController(),
                required: true,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceSmaller,
              CustomTextFormField(
                label: "Account Number",
                controller: TextEditingController(),
                required: true,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceSmaller,
              CustomTextFormField(
                label: "Account Holder Name",
                controller: TextEditingController(),
                required: true,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceSmaller,
              CustomTextFormField(
                label: "File",
                controller: TextEditingController(),
                required: false,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceLarge,
              BlocBuilder<AccountCrudBloc, AccountCrudState>(
                builder: (context, state) {
                  if (state is AccountCrudLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ActionButton(
                    onPressed: () {},
                    child: Text(
                      'SUBMIT',
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
    );
  }
}
