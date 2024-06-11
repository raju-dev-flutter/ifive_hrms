import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../dashboard/dashboard.dart';
import '../../appreciation.dart';

class AppreciationScreen extends StatefulWidget {
  const AppreciationScreen({super.key});

  @override
  State<AppreciationScreen> createState() => _AppreciationScreenState();
}

class _AppreciationScreenState extends State<AppreciationScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final appreciation = sl<AppreciationStream>();

  @override
  void initState() {
    super.initState();
    appreciation.fetchInitiateCallBack();
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
          title: "Appreciation",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return BlocConsumer<AppreciationCrudBloc, AppreciationCrudState>(
      listener: (context, state) {
        if (state is AppreciationCrudSuccess) {
          Navigator.pop(context);
          AppAlerts.displaySnackBar(
              context, "Appreciation Successfully Created", true);
          BlocProvider.of<AppreciationCubit>(context, listen: false)
              .getAppreciation();
        }
        if (state is AppreciationCrudFailed) {
          AppAlerts.displaySnackBar(context, "Network Problem", false);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: Dimensions.kPaddingAllMedium,
            child: Column(
              children: [
                CustomStreamDropDownWidget(
                  label: "Employee",
                  required: true,
                  streamList: appreciation.employeeList,
                  valueListInit: appreciation.employeeListInit,
                  onChanged: (val) {
                    if (val != '') appreciation.employee(val);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                CustomTextFormField(
                  label: "Description",
                  controller: appreciation.descriptionController,
                  required: true,
                  maxLines: 4,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceLarger,
                state is AppreciationCrudLoading
                    ? const CircularProgressIndicator()
                    : ActionButton(
                        onPressed: () => appreciation.onSubmit(context),
                        child: Text(
                          'SUBMIT',
                          style: context.textTheme.labelLarge
                              ?.copyWith(color: appColor.white),
                        ),
                      ),
                Dimensions.kVerticalSpaceSmall,
              ],
            ),
          ),
        );
      },
    );
  }
}
