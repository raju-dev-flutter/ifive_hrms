import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../payroll.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    BlocProvider.of<PaySlipCubit>(context).payslip(
        DateFormat('yyyy-MM-dd').format(selectedFromDate),
        DateFormat('yyyy-MM-dd').format(selectedToDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Payroll",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return Column(
      children: [
        PayrollFilterWidget(
          fromDate: selectedFromDate,
          toDate: selectedToDate,
          selectFromDate: () async {
            DateTime date = await PickDateTime.date(context,
                selectedDate: selectedFromDate, startDate: null);
            setState(() => selectedFromDate = date);
            initialCallBack();
          },
          selectToDate: () async {
            DateTime date = await PickDateTime.date(context,
                selectedDate: selectedToDate, startDate: null);
            setState(() => selectedToDate = date);
            initialCallBack();
          },
          search: initialCallBack,
        ),
        Expanded(
          child: BlocBuilder<PaySlipCubit, PaySlipState>(
            builder: (context, state) {
              if (state is PaySlipLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PaySlipLoaded) {
                final payroll = state.payroll.paySlipList!;
                if (payroll.isEmpty) {
                  return Container();
                }
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                          .w,
                  itemCount: payroll.length,
                  itemBuilder: (_, i) {
                    return PayrollDetailWidget(payroll: payroll[i]);
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
