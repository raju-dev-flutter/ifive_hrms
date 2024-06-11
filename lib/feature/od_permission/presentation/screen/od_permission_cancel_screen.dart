import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class ODPermissionCancelScreen extends StatefulWidget {
  final Odphistory permission;
  const ODPermissionCancelScreen({super.key, required this.permission});

  @override
  State<ODPermissionCancelScreen> createState() =>
      _ODPermissionCancelScreenState();
}

class _ODPermissionCancelScreenState extends State<ODPermissionCancelScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final reasonController = TextEditingController();

  late String status = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: widget.permission.status == "INITIATED"
              ? "Od / Permission Cancel"
              : "Od / Permission Details",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocConsumer<PermissionCrudBloc, PermissionCrudState>(
        listener: (context, state) {
          if (state is PermissionCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "OD | Permission Successfully Canceled", true);
            // AppAlerts.displaySuccessAlert(context, "OD | Permission",
            //     "OD | Permission Successfully Canceled");
          }
          if (state is PermissionCrudFailed) {
            if (state.message == "Invalid Token") {
              BlocProvider.of<AuthenticationBloc>(context, listen: false)
                  .add(const LoggedOut());
            } else if (state.message == "Network Error") {
              AppAlerts.displaySnackBar(context, state.message, false);
              // AppAlerts.displayErrorAlert(
              //     context, "OD | Permission", state.message);
            } else {
              AppAlerts.displaySnackBar(context, state.message, false);
              // AppAlerts.displayWarningAlert(
              //     context, "OD | Permission", state.message);
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
                            value: widget.permission.username ?? '',
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Employee Id',
                            value: widget.permission.employeeId ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Status',
                            value: widget.permission.status ?? '',
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
                            value: widget.permission.date ?? '',
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Requested For',
                            value: widget.permission.permissionType ?? '',
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
                            label: 'Time',
                            value:
                                "${widget.permission.inTime == null ? ' ' : widget.permission.inTime!.split(' ').last} "
                                " ${widget.permission.outTime == null ? ' ' : widget.permission.outTime!.split(' ').last}",
                          ),
                        ),
                        Expanded(
                          child: leaveDetailCard(
                            label: 'No of Minutes',
                            value: widget.permission.noOfMinutes.toString(),
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
                            label: 'OD | Permission Reason',
                            value: widget.permission.reason ?? '',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              if (widget.permission.status == "APPROVED")
                widget.permission.reason1 == null ||
                        widget.permission.reason1 == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Approval Reason',
                                    value: widget.permission.reason1 ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.permission.status == "REJECT")
                widget.permission.reason1 == null ||
                        widget.permission.reason1 == ''
                    ? const SizedBox()
                    : leaveContainerCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: leaveDetailCard(
                                    label: 'Rejected Reason',
                                    value: widget.permission.reason1 ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.permission.status == "CANCELLED")
                widget.permission.cancelComments == null ||
                        widget.permission.cancelComments == ''
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
                                        widget.permission.cancelComments ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              if (widget.permission.status == "INITIATED")
                leaveContainerCard(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: "Reason",
                        controller: reasonController,
                        maxLines: 3,
                        required: false,
                      ),
                      Dimensions.kVerticalSpaceMedium,
                      state is PermissionCrudLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ActionButton(
                              onPressed: onSubmit,
                              color: appColor.warning600,
                              child: Text(
                                'CANCEL',
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
      "od_permission_id": widget.permission.odPermissionId,
      "status": "CANCELLED",
      "cancel_comments": reasonController.text,
    };

    Logger().t("Submit Body: $body");

    BlocProvider.of<PermissionCrudBloc>(context)
        .add(PermissionCancelEvent(body: body));
  }
}
