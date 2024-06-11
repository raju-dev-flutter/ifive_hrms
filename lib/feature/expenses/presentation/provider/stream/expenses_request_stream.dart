import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../expenses.dart';

class ExpensesSaveStream {
  ExpensesSaveStream({required ExpensesTypeUseCase expensesTypeUseCase})
      : _expensesTypeUseCase = expensesTypeUseCase;

  final ExpensesTypeUseCase _expensesTypeUseCase;

  late TextEditingController countController = TextEditingController();
  late TextEditingController travelKmController = TextEditingController();
  late TextEditingController amountController = TextEditingController();
  late TextEditingController remarksController = TextEditingController();

  final _expenseTypeList = BehaviorSubject<List<ExpensesTypeData>>.seeded([]);
  final _expenseTypeListInit = BehaviorSubject<ExpensesTypeData>();

  final _employeeList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _employeeListInit = BehaviorSubject<CommonList>();

  final _timePeriodList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _timePeriodListInit = BehaviorSubject<CommonList>();

  final _date = BehaviorSubject<DateTime?>();
  final _selectDate = BehaviorSubject<String>();

  Stream<List<ExpensesTypeData>> get expenseTypeList => _expenseTypeList.stream;

  ValueStream<ExpensesTypeData> get expenseTypeListInit =>
      _expenseTypeListInit.stream;

  Stream<List<CommonList>> get employeeList => _employeeList.stream;

  ValueStream<CommonList> get employeeListInit => _employeeListInit.stream;

  Stream<List<CommonList>> get timePeriodList => _timePeriodList.stream;

  ValueStream<CommonList> get timePeriodListInit => _timePeriodListInit.stream;

  ValueStream<DateTime?> get date => _date.stream;

  ValueStream<String> get selectDate => _selectDate.stream;

  Future<void> fetchInitialCallBack() async {
    _timePeriodList.sink.add([
      CommonList(id: 1, name: "First off"),
      CommonList(id: 2, name: "Second off"),
    ]);

    final expensesResponse = await _expensesTypeUseCase();
    expensesResponse.fold(
      (_) => null,
      (_) {
        if (_.employeeListData!.isNotEmpty) {
          _employeeList.sink.add(_.employeeListData ?? []);
        }
        if (_.expensesTypeData!.isNotEmpty) {
          _expenseTypeList.sink.add(_.expensesTypeData ?? []);
        }
      },
    );
  }

  void employee(params) {
    _employeeListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void expenseType(ExpensesTypeData params) {
    _expenseTypeListInit.sink.add(ExpensesTypeData(
        expenseTypeId: params.expenseTypeId,
        expenseType: params.expenseType,
        amount: params.amount));
    onClear();
  }

  void timePeriod(params) {
    _timePeriodListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void calculateCountBasedAmount() {
    final amount = _expenseTypeListInit.valueOrNull!.amount;
    final count = countController.text;
    final totalAmount = calculateAmount(
        amount != '0' && amount != null ? amount : '0',
        count != '' ? count : '0');

    amountController.text = totalAmount;
  }

  void calculateKmBasedAmount() {
    final amount = _expenseTypeListInit.valueOrNull!.amount;
    final km = travelKmController.text;
    final totalAmount = calculateAmount(
        amount != '0' && amount != null ? amount : '0', km != '' ? km : '0');

    amountController.text = totalAmount;
  }

  String calculateAmount(amount, howMany) {
    if (amount == '0' || howMany == '0') {
      return "";
    }
    final totalAmount = int.parse(amount) * int.parse(howMany);
    return totalAmount.toString();
  }

  void selectedDate(DateTime date) {
    _date.sink.add(date);
    _selectDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  Future<void> onSubmit(BuildContext context) async {
    final body = {
      "date": _selectDate.valueOrNull ?? "",
      "expense_type_id": _expenseTypeListInit.valueOrNull?.expenseTypeId ?? 0,
      "employee_id": _employeeListInit.valueOrNull?.id ?? 0,
      "count": countController.text,
      "travel": travelKmController.text,
      "time_of_day": _timePeriodListInit.valueOrNull?.name ?? "",
      "amount": amountController.text,
      "remarks": remarksController.text,
    };

    BlocProvider.of<ExpensesCrudBloc>(context)
        .add(ExpensesSaveEvent(body: body));
  }

  Future<void> onUpdate(BuildContext context, String id, String status) async {
    final body = {"expense_id": id, "status": status};

    BlocProvider.of<ExpensesCrudBloc>(context)
        .add(ExpensesSaveEvent(body: body));
  }

  void onClear() {
    countController.clear();
    travelKmController.clear();
    amountController.clear();
    remarksController.clear();

    _employeeListInit.sink.add(CommonList());
    _timePeriodListInit.sink.add(CommonList());
  }

  void onDispose() {
    countController.dispose();
    travelKmController.dispose();
    amountController.dispose();
    remarksController.dispose();

    _expenseTypeList.close();
    _expenseTypeListInit.close();
    _employeeList.close();
    _employeeListInit.close();
    _timePeriodList.close();
    _timePeriodListInit.close();
  }
}
