import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../od_permission.dart';

class ODPermissionRequestScreen extends StatefulWidget {
  const ODPermissionRequestScreen({super.key});

  @override
  State<ODPermissionRequestScreen> createState() =>
      _ODPermissionRequestScreenState();
}

class _ODPermissionRequestScreenState extends State<ODPermissionRequestScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final permissionStream = sl<ODPermissionRequestStream>();

  @override
  void initState() {
    super.initState();
    permissionStream.fetchInitialCallBack();
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
          title: "OD / Permission Request",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      child: BlocConsumer<PermissionCrudBloc, PermissionCrudState>(
        listener: (context, state) {
          if (state is PermissionCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "OD | Permission Successfully Applied", true);
          }
          if (state is PermissionCrudFailed) {
            if (state.message == "Invalid Token") {
              BlocProvider.of<AuthenticationBloc>(context, listen: false)
                  .add(const LoggedOut());
            } else if (state.message == "Network Error") {
              AppAlerts.displaySnackBar(context, state.message, false);
            } else {
              AppAlerts.displaySnackBar(context, state.message, false);
            }
          }
        },
        builder: (context, state) {
          return Container(
            width: context.deviceSize.width,
            padding: Dimensions.kPaddingAllMedium,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomStreamDropDownWidget(
                    label: "Request For",
                    required: true,
                    streamList: permissionStream.requestList,
                    valueListInit: permissionStream.requestListInit,
                    onChanged: (val) {
                      if (val != '') permissionStream.request(val);
                      setState(() {});
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<dynamic>(
                      stream: permissionStream.balanceOdSubject,
                      builder: (context, snapshot) {
                        return CustomTextFormField(
                          label: "Balance",
                          controller: TextEditingController(
                              text: snapshot.data.toString()),
                          required: true,
                          readOnly: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required *";
                            }
                            return null;
                          },
                        );
                      }),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomStreamDropDownWidget(
                    label: "Shift",
                    required: true,
                    streamList: permissionStream.shiftTimeList,
                    valueListInit: permissionStream.shiftTimeListInit,
                    onChanged: (val) {
                      if (val != '') permissionStream.shiftTime(val);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomDateTimeTextFormField(
                    label: 'Date',
                    required: true,
                    controller: TextEditingController(
                        text: permissionStream.selectDate.valueOrNull ?? ''),
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) {
                        return "required *";
                      }
                      return null;
                    },
                    onPressed: () async {
                      DateTime date = await PickDateTime.date(context,
                          selectedDate: permissionStream.fromDate.valueOrNull,
                          startDate: null);
                      permissionStream.selectedDate(date);
                      setState(() {});
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomDateTimeTextFormField(
                    label: 'Actual In Time',
                    required: true,
                    controller: TextEditingController(
                        text:
                            permissionStream.selectFromTime.valueOrNull ?? ''),
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) {
                        return "required *";
                      }
                      return null;
                    },
                    onPressed: () async {
                      DateTime date = await PickDateTime.date(context,
                          selectedDate: null, startDate: null);
                      TimeOfDay time = await PickDateTime.time(context);
                      permissionStream.selectedFromTime(context, date, time);
                      setState(() {});
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomDateTimeTextFormField(
                    label: 'Actual Out Time',
                    required: true,
                    controller: TextEditingController(
                        text: permissionStream.selectToTime.valueOrNull ?? ''),
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) {
                        return "required *";
                      }
                      return null;
                    },
                    onPressed: () async {
                      DateTime date = await PickDateTime.date(context,
                          selectedDate: null, startDate: null);
                      TimeOfDay time = await PickDateTime.time(context);
                      permissionStream.selectedToTime(context, date, time);
                      setState(() {});
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Number of Minutes",
                    controller: TextEditingController(
                      text: PickDateTime.calculateTimeInterval(
                        permissionStream.fromDate.valueOrNull,
                        permissionStream.fromTime.valueOrNull,
                        permissionStream.toDate.valueOrNull,
                        permissionStream.toTime.valueOrNull,
                      ),
                    ),
                    required: false,
                    readOnly: true,
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "OD/Permission Status",
                    controller: permissionStream.statusController,
                    required: true,
                    readOnly: true,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<String>(
                      stream: permissionStream.forwardSubject,
                      builder: (context, snapshot) {
                        return CustomTextFormField(
                          label: "Forwarded To",
                          controller:
                              TextEditingController(text: snapshot.data ?? ""),
                          required: true,
                          readOnly: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required *";
                            }
                            return null;
                          },
                        );
                      }),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Reason",
                    controller: permissionStream.reasonController,
                    required: true,
                    maxLines: 3,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  state is PermissionCrudLoading
                      ? const CircularProgressIndicator()
                      : ActionButton(
                          onPressed: () => {
                            if (_formKey.currentState!.validate())
                              permissionStream.onSubmit(context)
                          },
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
      ),
    );
  }
}
