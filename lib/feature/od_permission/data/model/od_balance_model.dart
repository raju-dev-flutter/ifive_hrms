import '../../../../core/core.dart';

class ODBalanceModel {
  int? message;

  ODBalanceModel({this.message});

  ODBalanceModel.fromJson(DataMap json) {
    message = json['message'];
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
