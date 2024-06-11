import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../account/account.dart';
import '../../auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isNewPasswordShow = false;
  bool _isConfirmPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Change Password",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            Navigator.pop(context);
            BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
            AppAlerts.displaySnackBar(
                context, "Password Successfully Changed", true);
          }
          if (state is ChangePasswordFailed) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Password Changes Failed", false);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Password",
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: appColor.gray900.withOpacity(.7)),
                ),
                SizedBox(height: 4.h),
                TextFormField(
                  controller: newPasswordController,
                  enableSuggestions: true,
                  obscureText: !_isNewPasswordShow,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.text,
                  decoration: inputDecoration(label: "New Password"),
                  style: context.textTheme.bodySmall,
                  validator: (user) {
                    if (!isCheckTextFieldIsEmpty(user!)) {
                      return "Please enter your new password";
                    } else {
                      return null;
                    }
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                Text(
                  "Confirm Password",
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: appColor.gray900.withOpacity(.7)),
                ),
                SizedBox(height: 4.h),
                TextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: !_isConfirmPasswordShow,
                  enableSuggestions: true,
                  enableInteractiveSelection: true,
                  decoration: inputDecoration(label: "Confirm Password"),
                  style: context.textTheme.bodySmall,
                  validator: (password) {
                    if (!isCheckTextFieldIsEmpty(password!)) {
                      return "Please enter your confirm password";
                    }
                    if (!isConformPassword(
                        newPasswordController.text, password)) {
                      return "Incorrect password";
                    }
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceLarge,
                state is ChangePasswordLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ActionButton(
                        onPressed: onSubmit,
                        child: Text(
                          'CHANGE PASSWORD',
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

  InputDecoration inputDecoration({required String label}) {
    final isPassword = label == "New Password";
    return InputDecoration(
      suffixIcon: GestureDetector(
        onTap: () => isPassword
            ? setState(() => _isNewPasswordShow = !_isNewPasswordShow)
            : setState(() => _isConfirmPasswordShow = !_isConfirmPasswordShow),
        child: isPassword
            ? Icon(
                _isNewPasswordShow ? Icons.lock_open : Icons.lock,
                size: 20,
                color: _isNewPasswordShow
                    ? appColor.gray900
                    : Colors.grey.shade500,
              )
            : Icon(
                _isConfirmPasswordShow ? Icons.lock_open : Icons.lock,
                size: 20,
                color: _isConfirmPasswordShow
                    ? appColor.gray900
                    : Colors.grey.shade500,
              ),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.blue600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      // labelText: label,
      labelStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray700),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 12).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error600),
    );
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      context
          .read<AuthBloc>()
          .add(ChangePasswordEvent(password: confirmPasswordController.text));
    }
  }
}
