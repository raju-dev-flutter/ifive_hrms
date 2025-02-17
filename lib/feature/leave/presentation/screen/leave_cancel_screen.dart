import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class LeaveCancelScreen extends StatefulWidget {
  final Leavehistory leave;

  const LeaveCancelScreen({super.key, required this.leave});

  @override
  State<LeaveCancelScreen> createState() => _LeaveCancelScreenState();
}

class _LeaveCancelScreenState extends State<LeaveCancelScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: widget.leave.leaveStatus == "INITIATED"
              ? "Leave Cancel"
              : "Leave Details",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocConsumer<LeaveCrudBloc, LeaveCrudState>(
        listener: (context, state) {
          if (state is LeaveCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Leave Successfully canceled", true);
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
          return Column(
            children: [
              leaveContainerCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Employee Name',
                            value: widget.leave.username ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Status',
                            value: widget.leave.leaveStatus ?? '',
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Requested Date',
                            value: widget.leave.startDate ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Leave Period',
                            value:
                                "${widget.leave.startDate} - ${widget.leave.endDate}",
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Forward To',
                            value: widget.leave.reportname ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Leave Mode',
                            value: widget.leave.leavemode ?? '',
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
                            label: 'Leave Type',
                            value: widget.leave.lookupMeaning ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Leave Days',
                            value: widget.leave.noOfDays.toString(),
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
                            label: 'Leave Reason',
                            value: widget.leave.leaveReason ?? '',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              if (widget.leave.leaveStatus == "APPROVE")
                widget.leave.approvelComments == null ||
                        widget.leave.approvelComments == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Approval Comments',
                                    value: widget.leave.approvelComments ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.leave.leaveStatus == "APPROVE")
                widget.leave.approvelComments == null ||
                        widget.leave.approvelComments == ''
                    ? const SizedBox()
                    : Dimensions.kVerticalSpaceSmall,
              if (widget.leave.leaveStatus == "APPROVE")
                widget.leave.approvalReason == null ||
                        widget.leave.approvalReason == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Approval Reason',
                                    value: widget.leave.approvalReason ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.leave.leaveStatus == "REJECT")
                (widget.leave.approvalReason == null ||
                            widget.leave.approvalReason == '') &&
                        (widget.leave.approvelComments == null ||
                            widget.leave.approvelComments == '')
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Rejected Reason',
                                    value: widget.leave.approvalReason ??
                                        widget.leave.approvelComments ??
                                        '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.leave.leaveStatus == "CANCELLED")
                widget.leave.cancelComments == null ||
                        widget.leave.cancelComments == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Cancel Reason',
                                    value: widget.leave.cancelComments ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.leave.leaveStatus == "INITIATED")
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
                      state is LeaveCrudLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ActionButton(
                              onPressed: onSubmit,
                              color: appColor.warning600,
                              child: Text(
                                'CANCEL LEAVE',
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
      "leave_id": widget.leave.leaveId,
      "status": "CANCELLED",
      "cancel_comments": reasonController.text,
    };

    Logger().t("Submit Body: $body");

    BlocProvider.of<LeaveCrudBloc>(context).add(LeaveCancelEvent(body: body));
  }
}
