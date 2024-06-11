import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class LeaveUpdateScreen extends StatefulWidget {
  final Leavelist leave;

  const LeaveUpdateScreen({super.key, required this.leave});

  @override
  State<LeaveUpdateScreen> createState() => _LeaveUpdateScreenState();
}

class _LeaveUpdateScreenState extends State<LeaveUpdateScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final reasonController = TextEditingController();
  final allotedController = TextEditingController();
  final commentsController = TextEditingController();

  late String status = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Leave Update",
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
                context, "Leave Successfully updated", true);
            // AppAlerts.displaySuccessAlert(
            //     context, "Leave", "Leave successfully updated");
          }
          if (state is LeaveCrudFailed) {
            if (state.message == "Invalid Token") {
              BlocProvider.of<AuthenticationBloc>(context, listen: false)
                  .add(const LoggedOut());
            } else if (state.message == "Network Error") {
              AppAlerts.displaySnackBar(context, state.message, false);
              // AppAlerts.displayErrorAlert(context, "Leave", state.message);
            } else {
              AppAlerts.displaySnackBar(context, state.message, false);
              // AppAlerts.displayWarningAlert(context, "Leave", state.message);
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
                    Divider(color: appColor.brand600.withOpacity(.1)),
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
                    Divider(color: appColor.brand600.withOpacity(.1)),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            label: 'Available Days',
                            value: widget.leave.availableLeave.toString(),
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
              leaveContainerCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: status != "REJECT"
                              ? DefaultActionButton(
                                  onPressed: () => changeState("REJECT"),
                                  label: "REJECT")
                              : ActionButton(
                                  onPressed: () => changeState(""),
                                  color: appColor.error600,
                                  child: Text(
                                    'REJECT',
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(color: appColor.white),
                                  ),
                                ),
                        ),
                        Dimensions.kHorizontalSpaceSmaller,
                        Expanded(
                          child: status != "APPROVE"
                              ? DefaultActionButton(
                                  onPressed: () => changeState("APPROVE"),
                                  label: "APPROVE")
                              : ActionButton(
                                  onPressed: () => changeState(""),
                                  color: appColor.success600,
                                  child: Text(
                                    'APPROVE',
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(color: appColor.white),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    status == "REJECT" || status == ""
                        ? const SizedBox()
                        : Dimensions.kVerticalSpaceSmaller,
                    status == "REJECT" || status == ""
                        ? const SizedBox()
                        : CustomTextFormField(
                            label: "Alloted Day",
                            controller: allotedController,
                            required: false,
                          ),
                    status == "REJECT" || status == ""
                        ? const SizedBox()
                        : Dimensions.kVerticalSpaceSmaller,
                    status == "REJECT" || status == ""
                        ? const SizedBox()
                        : CustomTextFormField(
                            label: "Comment",
                            controller: commentsController,
                            required: false,
                          ),
                    Dimensions.kVerticalSpaceSmaller,
                    CustomTextFormField(
                      label: "Reason",
                      controller: reasonController,
                      maxLines: 3,
                      required: false,
                    ),
                    Dimensions.kVerticalSpaceMedium,
                    state is LeaveCrudLoading
                        ? const Center(child: CircularProgressIndicator())
                        : status == ""
                            ? const DefaultActionButton(label: "SUBMIT")
                            : ActionButton(
                                onPressed: onSubmit,
                                color: appColor.warning600,
                                child: Text(
                                  'SUBMIT',
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

  changeState(val) {
    setState(() => status = val);
  }

  Widget leaveContainerCard({required Widget child}) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      decoration: BoxDecoration(
        color: appColor.gray50,
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

  Widget leaveDetailCard(
      {required String label,
      required String value,
      CrossAxisAlignment? crossAxisAlignment}) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
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
      "status": status,
      "alloted": status == "REJECT" ? " " : allotedController.text,
      "Approval_reason": reasonController.text,
      "Approval_comments": status == "REJECT" ? " " : commentsController.text,
    };

    Logger().t("Submit Body: $body");

    BlocProvider.of<LeaveCrudBloc>(context).add(LeaveUpdateEvent(body: body));
  }
}
