import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final leaveRequest = sl<LeaveRequestStream>();

  @override
  void initState() {
    super.initState();
    leaveRequest.fetchInitialCallBack();
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
          title: "Leave Request",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      child: BlocConsumer<LeaveCrudBloc, LeaveCrudState>(
        listener: (context, state) {
          if (state is LeaveCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Leave Successfully applied", true);
          }
          if (state is LeaveCrudFailed) {
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
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomStreamDropDownWidget(
                    label: "Leave Type",
                    required: true,
                    streamList: leaveRequest.leaveTypeList,
                    valueListInit: leaveRequest.leaveTypeListInit,
                    onChanged: (val) {
                      if (val != '') leaveRequest.type(val, context);
                      setState(() {});
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<String>(
                    stream: leaveRequest.leaveRemaining,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10).h,
                        child: CustomTextFormField(
                          label: "Balance Leave",
                          controller: TextEditingController(
                              text: (snapshot.data ?? 0).toString()),
                          required: false,
                          readOnly: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required *";
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                  // Dimensions.kVerticalSpaceSmaller,
                  CustomStreamDropDownWidget(
                    label: "Leave Mode",
                    required: true,
                    streamList: leaveRequest.leaveModeList,
                    valueListInit: leaveRequest.leaveModeListInit,
                    onChanged: (val) {
                      if (val != '') leaveRequest.mode(val, context);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<CommonList>(
                      stream: leaveRequest.leaveModeListInit,
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            Expanded(
                              child: CustomDateTimeTextFormField(
                                label: 'From Date',
                                required: true,
                                controller: TextEditingController(
                                    text: leaveRequest
                                            .selectFromDate.valueOrNull ??
                                        ''),
                                validator: (val) {
                                  if (!isCheckTextFieldIsEmpty(val!)) {
                                    return "required *";
                                  }
                                  return null;
                                },
                                onPressed: () async {
                                  DateTime date = await PickDateTime.date(
                                      context,
                                      selectedDate:
                                          leaveRequest.fromDate.valueOrNull,
                                      startDate: DateTime.now());
                                  leaveRequest.selectedFromDate(date, context);
                                  setState(() {});
                                },
                              ),
                            ),
                            Dimensions.kHorizontalSpaceSmaller,
                            Expanded(
                              child: CustomDateTimeTextFormField(
                                label: 'To Date',
                                required: true,
                                controller: TextEditingController(
                                    text:
                                        leaveRequest.selectToDate.valueOrNull ??
                                            ''),
                                validator: (val) {
                                  if (!isCheckTextFieldIsEmpty(val!)) {
                                    return "required *";
                                  }
                                  return null;
                                },
                                onPressed: () async {
                                  DateTime date = await PickDateTime.date(
                                      context,
                                      selectedDate:
                                          leaveRequest.toDate.valueOrNull,
                                      startDate: DateTime.now());
                                  leaveRequest.selectedToDate(date, context);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<LeaveBalanceModel>(
                      stream: leaveRequest.calculateLeaveBalance,
                      builder: (context, snapshot) {
                        // final isCheck = snapshot.data?.name == "HALF DAY" &&
                        //     snapshot.data?.name != null;
                        //
                        // final isDay = PickDateTime.noOfDays(
                        //     leaveRequest.fromDate.valueOrNull,
                        //     leaveRequest.toDate.valueOrNull);
                        // double isLength = isDay.toDouble();
                        //
                        // if (isCheck) {
                        //   if (isDay == 1) isLength = 0.5;
                        // }

                        // if (snapshot.data?.message != "SUCCESS") {
                        //   AppAlerts.displayWarningAlert(context,
                        //       "Leave Request", snapshot.data?.message ?? '');
                        // }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10).h,
                          child: CustomTextFormField(
                            label: "No. of days",
                            controller: TextEditingController(
                                text: (snapshot.data?.totalLeave ?? 0)
                                    .toString()),
                            required: false,
                            readOnly: true,
                            validator: (val) {
                              if (!isCheckTextFieldIsEmpty(val!)) {
                                return "required *";
                              }
                              return null;
                            },
                          ),
                        );
                        // }
                        // return Container();
                      }),
                  // Dimensions.kVerticalSpaceSmaller,

                  // Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Leave Status",
                    controller: leaveRequest.statusController,
                    required: true,
                    readOnly: true,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Forwarded To",
                    controller: TextEditingController(
                        text: leaveRequest.leaveForwardSubject.valueOrNull
                            .toString()),
                    required: false,
                    readOnly: true,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) {
                        return "required *";
                      }
                      return null;
                    },
                  ),
                  // CustomStreamDropDownWidget(
                  //   label: "Forwarded To",
                  //   required: true,
                  //   streamList: leaveRequest.leaveForwardList,
                  //   valueListInit: leaveRequest.leaveForwardListInit,
                  //   onChanged: (val) {
                  //     if (val != '') leaveRequest.forward(val);
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //   },
                  //   validator: (val) {
                  //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  //     return null;
                  //   },
                  // ),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Leave Reason",
                    controller: leaveRequest.reasonController,
                    maxLines: 4,
                    required: true,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  // state is LeaveCrudLoading
                  //     ? const CircularProgressIndicator()
                  //     : ActionButton(
                  //         onPressed: () => {
                  //           if (_formKey.currentState!.validate())
                  //             leaveRequest.onSubmit(context)
                  //         },
                  //         child: Text(
                  //           'SUBMIT',
                  //           style: context.textTheme.labelLarge
                  //               ?.copyWith(color: AppColor.textPrimaryOnBrand),
                  //         ),
                  //       ),
                  state is LeaveCrudLoading
                      ? const CircularProgressIndicator()
                      : ActionButton(onPressed: onSubmit, child: submitText()),
                  // StreamBuilder<String>(
                  //         stream: leaveRequest.leaveRemaining,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.hasData) {
                  //             final leaveType = leaveRequest
                  //                 .leaveTypeListInit.valueOrNull!.name;
                  //             // if (leaveType != "Sick Leave") {
                  //             // if (snapshot.data != 0) {
                  //             if (leaveType == "Privilege Leave") {
                  //               return StreamBuilder<LeaveBalanceModel>(
                  //                   stream: leaveRequest.calculateLeaveBalance,
                  //                   builder: (context, snapshot) {
                  //                     if (snapshot.data?.totalLeave == 3) {
                  //                       return ActionButton(
                  //                         onPressed: onSubmit,
                  //                         child: submitText(),
                  //                       );
                  //                     } else {
                  //                       return ActionButton(
                  //                         onPressed: () => {
                  //                           AppAlerts.displaySnackBar(
                  //                               context,
                  //                               snapshot.data?.message ?? '',
                  //                               false)
                  //                         },
                  //                         child: submitText(),
                  //                       );
                  //                     }
                  //                   });
                  //             } else {
                  //               return ActionButton(
                  //                 onPressed: onSubmit,
                  //                 child: submitText(),
                  //               );
                  //             }
                  //             // } else {
                  //             //   return ActionButton(
                  //             //     onPressed: () => {
                  //             //       AppAlerts.displaySnackBar(
                  //             //           context,
                  //             //           "No leave is available at this time, therefore please do not apply.",
                  //             //           false)
                  //             //     },
                  //             //     child: submitText(),
                  //             //   );
                  //             // }
                  //           }
                  //           // else {
                  //           //     return ActionButton(
                  //           //       onPressed: onSubmit,
                  //           //       child: submitText(),
                  //           //     );
                  //           //   }
                  //           // }
                  //           return const DefaultActionButton(label: 'SUBMIT');
                  //         }),
                  Dimensions.kVerticalSpaceSmall,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget submitText() => Text(
        'SUBMIT',
        style: context.textTheme.labelLarge?.copyWith(color: appColor.white),
      );

  void onSubmit() {
    if (_formKey.currentState!.validate()) leaveRequest.onSubmit(context);
  }
}
