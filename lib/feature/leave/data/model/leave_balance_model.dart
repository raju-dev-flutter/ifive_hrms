class LeaveBalanceModel {
  dynamic totalLeave;
  String? message;

  LeaveBalanceModel({this.totalLeave, this.message});

  LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    totalLeave = json['total_leave'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_leave'] = totalLeave;
    data['message'] = message;
    return data;
  }
}
