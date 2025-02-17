import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchRequestScreen extends StatefulWidget {
  const MisspunchRequestScreen({super.key});

  @override
  State<MisspunchRequestScreen> createState() => _MisspunchRequestScreenState();
}

class _MisspunchRequestScreenState extends State<MisspunchRequestScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final missPunch = sl<MissPunchRequestStream>();

  @override
  void initState() {
    super.initState();
    missPunch.fetchInitialCallBack();
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
          title: "Misspunch Request",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      child: BlocConsumer<MisspunchCrudBloc, MisspunchCrudState>(
        listener: (context, state) {
          if (state is MisspunchCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Misspunch Successfully Applied", true);
          }
          if (state is MisspunchCrudFailed) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomStreamDropDownWidget(
                    label: "Request For",
                    required: true,
                    streamList: missPunch.requestList,
                    valueListInit: missPunch.requestListInit,
                    onChanged: (val) {
                      if (val != '') missPunch.request(val);
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
                    label: "Misspunch Status",
                    controller: missPunch.statusController,
                    required: true,
                    readOnly: true,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<String>(
                      stream: missPunch.forwardSubject,
                      builder: (context, snapshot) {
                        return CustomTextFormField(
                          label: "Forwarded To",
                          controller:
                              TextEditingController(text: snapshot.data ?? ""),
                          required: true,
                          readOnly: true,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!))
                              return "required *";
                            return null;
                          },
                        );
                      }),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<String>(
                      stream: missPunch.selectDate,
                      builder: (context, snapshot) {
                        return CustomDateTimeTextFormField(
                          label: 'Date',
                          required: true,
                          controller:
                              TextEditingController(text: snapshot.data ?? ''),
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required *";
                            }
                            return null;
                          },
                          onPressed: () async {
                            DateTime date = await PickDateTime.date(context,
                                selectedDate: missPunch.date.valueOrNull,
                                startDate: null);
                            missPunch.selectedDate(date);
                            setState(() {});
                          },
                        );
                      }),
                  Dimensions.kVerticalSpaceSmaller,
                  StreamBuilder<CommonList>(
                      stream: missPunch.requestListInit,
                      builder: (context, snapshot) {
                        final isCheck =
                            snapshot.data?.name != "In Punch Missing" &&
                                snapshot.data?.name != "Out Punch Missing";
                        if (isCheck) {
                          return SizedBox(
                            width: context.deviceSize.width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomDateTimeTextFormField(
                                    label: 'ACTUAL IN-TIME',
                                    required: true,
                                    controller: TextEditingController(
                                        text: missPunch
                                                .selectFromTime.valueOrNull ??
                                            ''),
                                    validator: (val) {
                                      if (!isCheckTextFieldIsEmpty(val!)) {
                                        return "required *";
                                      }
                                      return null;
                                    },
                                    onPressed: () async {
                                      TimeOfDay time =
                                          await PickDateTime.time(context);
                                      missPunch.selectedFromTime(context, time);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Dimensions.kHorizontalSpaceSmaller,
                                Expanded(
                                  child: CustomDateTimeTextFormField(
                                    label: 'ACTUAL OUT-TIME',
                                    required: true,
                                    controller: TextEditingController(
                                        text: missPunch
                                                .selectToTime.valueOrNull ??
                                            ''),
                                    validator: (val) {
                                      if (!isCheckTextFieldIsEmpty(val!)) {
                                        return "required *";
                                      }
                                      return null;
                                    },
                                    onPressed: () async {
                                      TimeOfDay time =
                                          await PickDateTime.time(context);
                                      missPunch.selectedToTime(context, time);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return CustomDateTimeTextFormField(
                            label: 'Time',
                            required: true,
                            controller: TextEditingController(
                                text: missPunch.selectTime.valueOrNull ?? ''),
                            validator: (val) {
                              if (!isCheckTextFieldIsEmpty(val!)) {
                                return "required *";
                              }
                              return null;
                            },
                            onPressed: () async {
                              TimeOfDay time = await PickDateTime.time(context);
                              missPunch.selectedTime(context, time);
                              setState(() {});
                            },
                          );
                        }
                      }),
                  Dimensions.kVerticalSpaceSmaller,
                  CustomTextFormField(
                    label: "Reason",
                    controller: missPunch.reasonController,
                    required: true,
                    maxLines: 3,
                    validator: (val) {
                      if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                      return null;
                    },
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  state is MisspunchCrudLoading
                      ? const CircularProgressIndicator()
                      : ActionButton(
                          onPressed: () => {
                            if (_formKey.currentState!.validate())
                              missPunch.onSubmit(context)
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
