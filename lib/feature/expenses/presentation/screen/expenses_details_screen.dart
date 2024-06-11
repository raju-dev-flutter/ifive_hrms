import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../expenses.dart';

class ExpensesDetailsScreen extends StatefulWidget {
  final ExpensesData expenses;

  const ExpensesDetailsScreen({super.key, required this.expenses});

  @override
  State<ExpensesDetailsScreen> createState() => _ExpensesDetailsScreenState();
}

class _ExpensesDetailsScreenState extends State<ExpensesDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Expenses Details",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  void listener(BuildContext context, ExpensesCrudState state) {
    if (state is ExpensesCrudSuccess) {
      Navigator.pop(context);
      AppAlerts.displaySnackBar(context, "Expenses Successfully updated", true);
    }
    if (state is ExpensesCrudFailure) {
      if (state.message == "Invalid Token") {
        BlocProvider.of<AuthenticationBloc>(context, listen: false)
            .add(const LoggedOut());
      } else if (state.message == "Network Error") {
        AppAlerts.displaySnackBar(context, state.message, false);
      } else {
        AppAlerts.displaySnackBar(context, state.message, false);
      }
    }
  }

  Widget _buildBodyUI() {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocConsumer<ExpensesCrudBloc, ExpensesCrudState>(
        listener: listener,
        builder: (context, state) {
          return Column(
            children: [
              containerCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: detailCard(
                            label: 'Expense Type',
                            value: widget.expenses.expenseTypeName ?? '',
                          ),
                        ),
                        Expanded(
                          child: detailCard(
                            label: 'Date',
                            value: widget.expenses.date ?? '',
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand600.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: detailCard(
                            label: 'Time Period',
                            value: widget.expenses.timeOfDay ?? '',
                          ),
                        ),
                        Expanded(
                          child: detailCard(
                            label: 'Count',
                            value: "${widget.expenses.count ?? ''}",
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand600.withOpacity(.1)),
                    Row(
                      children: [
                        Expanded(
                          child: detailCard(
                            label: 'Employee Name',
                            value: widget.expenses.employeeName ?? '',
                          ),
                        ),
                        Expanded(
                          child: detailCard(
                            label: 'Km',
                            value: widget.expenses.travelInKm ?? "",
                          ),
                        ),
                      ],
                    ),
                    Divider(color: appColor.brand600.withOpacity(.1)),
                    detailCard(
                      label: 'Amount',
                      value: "${widget.expenses.amount ?? ''}",
                    ),
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              if (widget.expenses.remarks != null) ...[
                containerCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: detailCard(
                              label: 'Reason',
                              value: widget.expenses.remarks ?? '',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Dimensions.kVerticalSpaceSmall,
              ],
              if (widget.expenses.status == "INITIATED")
                containerCard(
                  child: Column(
                    children: [
                      state is ExpensesCrudLoading
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

  Widget containerCard({required Widget child}) {
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

  Widget detailCard(
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
      "expense_id": widget.expenses.expenseId,
      "status": "CANCELLED",
    };

    BlocProvider.of<ExpensesCrudBloc>(context)
        .add(ExpensesSaveEvent(body: body));
  }
}
