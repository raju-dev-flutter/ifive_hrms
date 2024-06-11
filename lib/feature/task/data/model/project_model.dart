import 'package:ifive_hrms/core/core.dart';

class ProjectModel {
  List<CommonList>? projectList;

  ProjectModel({this.projectList});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    if (json['projectdata'] != null) {
      projectList = <CommonList>[];
      json['projectdata'].forEach((v) {
        projectList!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (projectList != null) {
      data['projectdata'] = projectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
