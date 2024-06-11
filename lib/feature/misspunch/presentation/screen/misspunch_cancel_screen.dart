import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class MisspunchCancelScreen extends StatefulWidget {
  final MisspunchHistory missPunch;
  const MisspunchCancelScreen({super.key, required this.missPunch});

  @override
  State<MisspunchCancelScreen> createState() => _MisspunchCancelScreenState();
}

class _MisspunchCancelScreenState extends State<MisspunchCancelScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: widget.missPunch.status == "INITIATED"
              ? "Misspunch Cancel"
              : "Misspunch Details",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocConsumer<MisspunchCrudBloc, MisspunchCrudState>(
        listener: (context, state) {
          // if (state is MisspunchCrudSuccess) {
          //   Navigator.pop(context);
          //   AppAlerts.displaySnackBar(
          //       context, "Misspunch Successfully Cancel", true);
          // }
          // if (state is MisspunchCrudFailed) {
          //   AppAlerts.displaySnackBar(context, "Network Error", false);
          // }

          if (state is MisspunchCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Misspunch Successfully Canceled", true);
            // AppAlerts.displaySuccessAlert(
            //     context, "Misspunch", "Misspunch Successfully Canceled");
          }
          if (state is MisspunchCrudFailed) {
            if (state.message == "Invalid Token") {
              BlocProvider.of<AuthenticationBloc>(context, listen: false)
                  .add(const LoggedOut());
            } else if (state.message == "Network Error") {
              AppAlerts.displaySnackBar(context, state.message, false);
              // AppAlerts.displayErrorAlert(context, "Misspunch", state.message);
            } else {
              AppAlerts.displaySnackBar(context, state.message, false);
              // AppAlerts.displayWarningAlert(
              //     context, "Misspunch", state.message);
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              leaveContainerCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Requested For',
                            value: widget.missPunch.lookupCode ?? '',
                          ),
                        ),
                        // Expanded(
                        //   child: leaveDetailCard(
                        //     label: 'Leave Mode',
                        //     value: widget.leave.leavemode ?? '',
                        //   ),
                        // ),
                      ],
                    ),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Employee Id',
                            value: widget.missPunch.employeeId ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Status',
                            value: widget.missPunch.status ?? '',
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Date',
                            value: widget.missPunch.date ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Time',
                            value:
                                "${widget.missPunch.time == null || widget.missPunch.time == "0000-00-00 00:00:00" ? ' ' : widget.missPunch.time!.split(' ').last} "
                                "${widget.missPunch.inTime == null || widget.missPunch.inTime == "0000-00-00 00:00:00" ? ' ' : widget.missPunch.inTime!.split(' ').last} "
                                " ${widget.missPunch.outTime == null || widget.missPunch.outTime == "0000-00-00 00:00:00" ? ' ' : widget.missPunch.outTime!.split(' ').last}",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              leaveContainerCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Misspunch Reason',
                            value: widget.missPunch.reason ?? '',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              if (widget.missPunch.status == "APPROVED")
                widget.missPunch.reason1 == null ||
                        widget.missPunch.reason1 == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Approval Reason',
                                    value: widget.missPunch.reason1 ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.missPunch.status == "REJECTED")
                widget.missPunch.reason1 == null ||
                        widget.missPunch.reason1 == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Rejected Reason',
                                    value: widget.missPunch.reason1 ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.missPunch.status == "CANCELLED")
                widget.missPunch.cancelComments == null ||
                        widget.missPunch.cancelComments == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Cancel Reason',
                                    value:
                                        widget.missPunch.cancelComments ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.missPunch.status == "INITIATED")
                leaveContainerCard(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: "Reason for Cancellation",
                        controller: reasonController,
                        maxLines: 3,
                        required: false,
                      ),
                      Dimensions.kVerticalSpaceMedium,
                      state is MisspunchCrudLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ActionButton(
                              onPressed: onSubmit,
                              color: appColor.warning600,
                              child: Text(
                                'CANCEL MISSPUNCH',
                                style: context.textTheme.labelLarge
                                    ?.copyWith(color: appColor.white),
                              ),
                            ),
                    ],
                  ),
                ),
              Dimensions.kVerticalSpaceSmall,
            ],
          );
        },
      ),
    );
  }

  Widget leaveContainerCard({required Widget child}) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: BorderRadius.circular(8).w,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF5F5F5).withOpacity(.2),
            blurRadius: 12,
            offset: const Offset(0, 3),
            spreadRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget leaveDetailCard({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelMedium
              ?.copyWith(color: appColor.gray700, letterSpacing: .5),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: context.textTheme.labelMedium
              ?.copyWith(fontWeight: FontWeight.w500, letterSpacing: .5),
        ),
      ],
    );
  }

  void onSubmit() {
    final body = {
      "leave_id": widget.missPunch.missId,
      "status": "CANCELLED",
      "cancel_comments": reasonController.text,
    };

    Logger().t("Submit Body: $body");

    BlocProvider.of<MisspunchCrudBloc>(context)
        .add(MisspunchCancelEvent(body: body));
  }
}
