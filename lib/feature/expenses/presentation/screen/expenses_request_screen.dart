import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../expenses.dart';

class ExpensesRequestScreen extends StatefulWidget {
  const ExpensesRequestScreen({super.key});

  @override
  State<ExpensesRequestScreen> createState() => _ExpensesRequestScreenState();
}

class _ExpensesRequestScreenState extends State<ExpensesRequestScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final expensesSave = sl<ExpensesSaveStream>();

  @override
  void initState() {
    super.initState();
    expensesSave.fetchInitialCallBack();
  }

  @override
  void dispose() {
    expensesSave.onDispose();
    super.dispose();
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
          title: "Expenses Request",
        ),
      ),
      body: BlocListener<ExpensesCrudBloc, ExpensesCrudState>(
        listener: (context, state) {
          if (state is ExpensesCrudSuccess) {
            AppAlerts.displaySnackBar(
                context, "Expenses Successfully Requested", true);
            Navigator.pop(context);
          }
          if (state is ExpensesCrudFailure) {
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        },
        child: SingleChildScrollView(
          padding: Dimensions.kPaddingAllMedium,
          child: Form(key: _formKey, child: Column(children: _buildBodyUI())),
        ),
      ),
    );
  }

  List<Widget> _buildBodyUI() {
    return [
      StreamBuilder<ExpensesTypeData>(
          stream: expensesSave.expenseTypeListInit,
          builder: (_, d) {
            final type = d.hasData ? d.data?.expenseType ?? "" : "";
            return CustomDateTimeTextFormField(
              label: "Expenses Type",
              controller: TextEditingController(text: type),
              required: true,
              icon: AppSvg.achievement,
              onPressed: onTapExpensesType,
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            );
          }),
      Dimensions.kVerticalSpaceSmaller,
      CustomDateTimeTextFormField(
        label: "Expenses Date",
        controller: TextEditingController(
            text: expensesSave.selectDate.valueOrNull ?? ''),
        required: true,
        onPressed: () async {
          DateTime date = await PickDateTime.date(context,
              selectedDate: expensesSave.date.valueOrNull,
              endDate: DateTime.now());
          expensesSave.selectedDate(date);
          setState(() {});
        },
        validator: (val) {
          if (!isCheckTextFieldIsEmpty(val!)) return "required *";
          return null;
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      StreamBuilder<ExpensesTypeData>(
          stream: expensesSave.expenseTypeListInit,
          builder: (_, d) {
            bool isPetrol = d.hasData ? d.data?.expenseType == "Petrol" : false;
            bool isTea = d.hasData ? d.data?.expenseType == "Tea" : false;
            if (isPetrol) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8).w,
                child: CustomStreamDropDownWidget(
                  label: "Employee",
                  required: true,
                  streamList: expensesSave.employeeList,
                  valueListInit: expensesSave.employeeListInit,
                  onChanged: (params) {
                    expensesSave.employee(params);
                    setState(() {});
                  },
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
              );
            }
            if (isTea) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8).w,
                child: CustomStreamDropDownWidget(
                  label: "Time Period",
                  required: true,
                  streamList: expensesSave.timePeriodList,
                  valueListInit: expensesSave.timePeriodListInit,
                  onChanged: (params) {
                    expensesSave.timePeriod(params);
                    setState(() {});
                  },
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                ),
              );
            }
            return Container();
          }),
      StreamBuilder<ExpensesTypeData>(
          stream: expensesSave.expenseTypeListInit,
          builder: (_, d) {
            bool type = d.hasData
                ? d.data?.expenseType != "Other" &&
                    d.data?.expenseType != "Petrol"
                : false;
            bool isPetrol = d.hasData ? d.data?.expenseType == "Petrol" : false;
            if (type) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8).w,
                child: CustomTextFormField(
                  label: "Count",
                  controller: expensesSave.countController,
                  required: true,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                  onChanged: (v) => expensesSave.calculateCountBasedAmount(),
                ),
              );
            }
            if (isPetrol) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8).w,
                child: CustomTextFormField(
                  label: "Km",
                  controller: expensesSave.travelKmController,
                  required: true,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                    return null;
                  },
                  onChanged: (v) => expensesSave.calculateKmBasedAmount(),
                ),
              );
            }
            return Container();
          }),
      StreamBuilder<ExpensesTypeData>(
        stream: expensesSave.expenseTypeListInit,
        builder: (_, d) {
          bool type = d.hasData ? d.data?.expenseType == "Other" : false;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8).w,
            child: CustomTextFormField(
              label: "Amount",
              controller: expensesSave.amountController,
              required: true,
              readOnly: !type,
              maxLines: 1,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
          );
        },
      ),
      StreamBuilder<ExpensesTypeData>(
          stream: expensesSave.expenseTypeListInit,
          builder: (_, d) {
            bool type = d.hasData ? d.data?.expenseType == "Other" : false;
            if (type) {
              return CustomTextFormField(
                label: "Remarks",
                controller: expensesSave.remarksController,
                required: true,
                maxLines: 3,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              );
            }
            return Container();
          }),

      ///
      Dimensions.kVerticalSpaceLarge,
      BlocBuilder<ExpensesCrudBloc, ExpensesCrudState>(
        builder: (context, state) {
          if (state is ExpensesCrudLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ActionButton(
            onPressed: () => {
              if (_formKey.currentState!.validate())
                {expensesSave.onSubmit(context)}
            },
            label: 'SUBMIT',
          );
        },
      ),
      Dimensions.kVerticalSpaceSmall,
    ];
  }

  void onTapExpensesType() {
    AppAlerts.displayContentListAlert(
      context: context,
      title: 'Expenses Type',
      child: SizedBox(
        height: 200.h,
        child: StreamBuilder<List<ExpensesTypeData>>(
            stream: expensesSave.expenseTypeList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  padding: Dimensions.kPaddingAllMedium,
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      onTap: () {
                        expensesSave.expenseType(snapshot.data![position]);
                        Navigator.pop(context);
                      },
                      child: Text(
                        snapshot.data![position].expenseType ?? "",
                        style: context.textTheme.bodySmall,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(color: appColor.blue100);
                  },
                  itemCount: snapshot.data!.length,
                );
              }
              return Container();
            }),
      ),
    );
  }
}
