class PaySlipResponseModel {
  List<PaySlipResponse>? paySlipList;

  PaySlipResponseModel({this.paySlipList});

  PaySlipResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['paysliplist'] != null) {
      paySlipList = <PaySlipResponse>[];
      json['paysliplist'].forEach((v) {
        paySlipList!.add(PaySlipResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paySlipList != null) {
      data['paysliplist'] = paySlipList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaySlipResponse {
  int? id;
  int? employeeId;
  String? employeeNumber;
  String? firstName;
  String? monthName;
  int? month;
  String? year;

  PaySlipResponse(
      {this.id,
      this.employeeId,
      this.employeeNumber,
      this.firstName,
      this.monthName,
      this.month,
      this.year});

  PaySlipResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    employeeNumber = json['employee_number'];
    firstName = json['first_name'];
    monthName = json['month_name'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['employee_number'] = employeeNumber;
    data['first_name'] = firstName;
    data['month_name'] = monthName;
    data['month'] = month;
    data['year'] = year;
    return data;
  }
}
