import 'package:ifive_hrms/core/core.dart';

class ExpensesModel {
  List<CommonList>? employeeListData;
  List<ExpensesTypeData>? expensesTypeData;

  ExpensesModel({this.employeeListData, this.expensesTypeData});

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    if (json['employee_list_data'] != null) {
      employeeListData = <CommonList>[];
      json['employee_list_data'].forEach((v) {
        employeeListData!.add(CommonList.fromJson(v));
      });
    }
    if (json['expenses_type_data'] != null) {
      expensesTypeData = <ExpensesTypeData>[];
      json['expenses_type_data'].forEach((v) {
        expensesTypeData!.add(ExpensesTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeListData != null) {
      data['employee_list_data'] =
          employeeListData!.map((v) => v.toJson()).toList();
    }
    if (expensesTypeData != null) {
      data['expenses_type_data'] =
          expensesTypeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpensesTypeData {
  int? expenseTypeId;
  String? expenseType;
  String? amount;

  ExpensesTypeData({this.expenseTypeId, this.expenseType, this.amount});

  ExpensesTypeData.fromJson(Map<String, dynamic> json) {
    expenseTypeId = json['expense_type_id'];
    expenseType = json['expense_type'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expense_type_id'] = expenseTypeId;
    data['expense_type'] = expenseType;
    data['amount'] = amount;
    return data;
  }
}
