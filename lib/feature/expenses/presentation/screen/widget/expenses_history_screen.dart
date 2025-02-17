import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../expenses.dart';

class ExpensesHistoryScreen extends StatefulWidget {
  const ExpensesHistoryScreen({super.key});

  @override
  State<ExpensesHistoryScreen> createState() => _ExpensesHistoryScreenState();
}

class _ExpensesHistoryScreenState extends State<ExpensesHistoryScreen> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<StatusBasedExpensesCubit>(context)
        .getStatusBasedExpensesData(
      status: 'history',
      from: DateFormat('yyyy-MM-dd').format(selectedFromDate),
      to: DateFormat('yyyy-MM-dd').format(selectedToDate),
    );
  }

  Color getColor(String label) {
    switch (label) {
      case "INITIATED":
        return appColor.warning600;
      case "APPROVE":
        return appColor.success600;
      case "REJECT":
        return appColor.error600;
      case "CANCELLED":
        return appColor.error600;
    }

    return appColor.success600;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpensesFilterActionWidget(
          from: DateFormat('yyyy-MM-dd').format(selectedFromDate),
          to: DateFormat('yyyy-MM-dd').format(selectedToDate),
          onPressedSearch: initialCallBack,
          onPressedFromDate: () async {
            DateTime date = await PickDateTime.date(context,
                selectedDate: selectedFromDate, startDate: null);
            setState(() => selectedFromDate = date);
            initialCallBack();
          },
          onPressedToDate: () async {
            DateTime date = await PickDateTime.date(context,
                selectedDate: selectedToDate, startDate: null);
            setState(() => selectedToDate = date);
            initialCallBack();
          },
        ),
        Expanded(
          child:
              BlocBuilder<StatusBasedExpensesCubit, StatusBasedExpensesState>(
            builder: (context, state) {
              if (state is StatusBasedExpensesLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is StatusBasedExpensesLoaded) {
                final expenses = state.expenses;
                if (expenses.isEmpty) {
                  return Center(child: EmptyScreen(onPressed: initialCallBack));
                }
                return RefreshIndicator(
                  onRefresh: initialCallBack,
                  child: ListView.separated(
                    itemCount: expenses.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 16)
                        .w,
                    itemBuilder: (_, i) => expensesApprovalCardUI(
                        expenses[i], getColor(expenses[i].status!)),
                    separatorBuilder: (BuildContext context, int index) {
                      return Dimensions.kVerticalSpaceSmall;
                    },
                  ),
                );
              }
              if (state is StatusBasedExpensesFailure) {
                return Center(child: EmptyScreen(onPressed: initialCallBack));
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget expensesApprovalCardUI(ExpensesData expenses, Color color) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
          context, AppRouterPath.expensesDetailsScreen,
          arguments: ExpensesDetailsScreen(expenses: expenses)),
      borderRadius: BorderRadius.circular(8).w,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('EXPENSE TYPE : ',
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold, color: color)),
                Expanded(
                  child: Text(
                    expenses.expenseTypeName ?? '',
                    style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500, letterSpacing: .5),
                  ),
                ),
                tag(
                  label: expenses.status ?? "",
                  color: color,
                ),
              ],
            ),
            Dimensions.kVerticalSpaceSmaller,
            if (expenses.employeeName != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('EMPLOYEE NAME : ',
                      style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: color)),
                  Dimensions.kHorizontalSpaceSmaller,
                  Text(expenses.employeeName ?? '',
                      style: context.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('DATE :',
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold, color: color)),
                Dimensions.kHorizontalSpaceSmaller,
                Text(expenses.date ?? '',
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            Dimensions.kVerticalSpaceSmaller,
            if (expenses.timeOfDay != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('TIME PERIOD :',
                      style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: color)),
                  Dimensions.kHorizontalSpaceSmaller,
                  Text(" ${expenses.timeOfDay ?? ''}",
                      style: context.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
            ],
            if (expenses.travelInKm != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('KM :',
                      style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: color)),
                  Dimensions.kHorizontalSpaceSmaller,
                  Text(" ${expenses.travelInKm ?? ''}",
                      style: context.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
            ],
            if (expenses.count != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('COUNT :',
                      style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: color)),
                  Dimensions.kHorizontalSpaceSmaller,
                  Text(" ${expenses.count ?? ''}",
                      style: context.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('AMOUNT :',
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold, color: color)),
                Dimensions.kHorizontalSpaceSmaller,
                Text("Rs: ${expenses.amount ?? ''}",
                    style: context.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            if (expenses.employeeName != null) ...[
              Dimensions.kVerticalSpaceSmaller,
              Text("\" ${expenses.remarks ?? ''} \"",
                  maxLines: 2,
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: .8))
            ],
          ],
        ),
      ),
    );
  }

  Widget tag({required Color color, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4).w,
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.w500, color: color),
      ),
    );
  }
}
