import '../../../../core/core.dart';

class StateModel {
  List<CommonList>? state;

  StateModel({this.state});

  StateModel.fromJson(Map<String, dynamic> json) {
    if (json['state'] != null) {
      state = <CommonList>[];
      json['state'].forEach((v) {
        state!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (state != null) {
      data['state'] = state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
