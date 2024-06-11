class ExpensesDataModel {
  List<ExpensesData>? expensesData;

  ExpensesDataModel({this.expensesData});

  ExpensesDataModel.fromJson(Map<String, dynamic> json) {
    if (json['expenses_data'] != null) {
      expensesData = <ExpensesData>[];
      json['expenses_data'].forEach((v) {
        expensesData!.add(ExpensesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (expensesData != null) {
      data['expenses_data'] = expensesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpensesData {
  int? expenseId;
  String? expenseTypeId;
  String? expenseTypeName;
  String? date;
  int? month;
  int? year;
  int? employeeId;
  String? employeeName;
  int? count;
  String? travelInKm;
  String? timeOfDay;
  int? amount;
  String? remarks;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? organizationId;
  int? locationId;
  int? companyId;
  int? createdBy;
  int? lastUpdatedBy;

  ExpensesData(
      {this.expenseId,
      this.expenseTypeId,
      this.expenseTypeName,
      this.date,
      this.month,
      this.year,
      this.employeeId,
      this.employeeName,
      this.count,
      this.travelInKm,
      this.timeOfDay,
      this.amount,
      this.remarks,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.locationId,
      this.companyId,
      this.createdBy,
      this.lastUpdatedBy});

  ExpensesData.fromJson(Map<String, dynamic> json) {
    expenseId = json['expense_id'];
    expenseTypeId = json['expense_type_id'];
    expenseTypeName = json['expense_type_name'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    count = json['count'];
    travelInKm = json['travel_in_km'];
    timeOfDay = json['time_of_day'];
    amount = json['amount'];
    remarks = json['remarks'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    organizationId = json['organization_id'];
    locationId = json['location_id'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expense_id'] = expenseId;
    data['expense_type_id'] = expenseTypeId;
    data['expense_type_name'] = expenseTypeName;
    data['date'] = date;
    data['month'] = month;
    data['year'] = year;
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['count'] = count;
    data['travel_in_km'] = travelInKm;
    data['time_of_day'] = timeOfDay;
    data['amount'] = amount;
    data['remarks'] = remarks;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['organization_id'] = organizationId;
    data['location_id'] = locationId;
    data['company_id'] = companyId;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    return data;
  }
}
