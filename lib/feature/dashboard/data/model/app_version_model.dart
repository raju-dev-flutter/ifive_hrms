class AppVersionModel {
  String? version;
  String? url;

  AppVersionModel({this.version, this.url});

  AppVersionModel.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['url'] = url;
    return data;
  }
}
