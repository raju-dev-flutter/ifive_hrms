import '../../../../core/core.dart';

class MisspunchMessageModel {
  String? message;
  String? createdAt;

  MisspunchMessageModel({this.message, this.createdAt});

  MisspunchMessageModel.fromJson(DataMap json) {
    message = json['message'];
    createdAt = json['created_at'];
  }

  DataMap toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
