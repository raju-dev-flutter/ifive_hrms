import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class MisspunchUpdateScreen extends StatefulWidget {
  final MisspunchApproved missPunch;

  const MisspunchUpdateScreen({super.key, required this.missPunch});

  @override
  State<MisspunchUpdateScreen> createState() => _MisspunchUpdateScreenState();
}

class _MisspunchUpdateScreenState extends State<MisspunchUpdateScreen> {
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
          title: "Misspunch Update",
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
          if (state is MisspunchCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Misspunch Successfully Updated", true);
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
                            value: widget.missPunch.username ?? '',
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: leaveDetailCard(
                            label: 'Requested For',
                            value: widget.missPunch.lookmean ?? '',
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
              leaveContainerCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: status != "REJECTED"
                              ? ActionButton(
                                  onPressed: () => changeState("REJECTED"),
                                  color: appColor.gray100,
                                  textColor: appColor.gray600,
                                  label: "REJECTED",
                                )
                              : ActionButton(
                                  onPressed: () => changeState(""),
                                  color: appColor.error600,
                                  child: Text(
                                    'REJECTED',
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(color: appColor.white),
                                  ),
                                ),
                        ),
                        Dimensions.kHorizontalSpaceSmaller,
                        Expanded(
                          child: status != "APPROVED"
                              ? ActionButton(
                                  onPressed: () => changeState("APPROVED"),
                                  color: appColor.gray100,
                                  textColor: appColor.gray600,
                                  label: "APPROVED",
                                )
                              : ActionButton(
                                  onPressed: () => changeState(""),
                                  color: appColor.success600,
                                  child: Text(
                                    'APPROVED',
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(color: appColor.white),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    CustomTextFormField(
                      label: "Reason",
                      controller: reasonController,
                      maxLines: 3,
                      required: false,
                    ),
                    Dimensions.kVerticalSpaceMedium,
                    if (status.isNotEmpty) ...[
                      Dimensions.kVerticalSpaceMedium,
                      state is MisspunchCrudLoading
                          ? const Center(child: CircularProgressIndicator())
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

  changeState(val) => setState(() => status = val);

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
      "miss_id": widget.missPunch.missId,
      "status": status,
      "reason1": reasonController.text,
      "shift_change_id": "",
    };

    Logger().t("Submit Body: $body");

    BlocProvider.of<MisspunchCrudBloc>(context)
        .add(MisspunchUpdateEvent(body: body));
  }
}
