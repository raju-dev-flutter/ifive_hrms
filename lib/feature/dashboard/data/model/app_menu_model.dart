class AppMenuModel {
  List<MenuModel>? menuModel;

  AppMenuModel({this.menuModel});

  AppMenuModel.fromJson(Map<String, dynamic> json) {
    if (json['menu_list'] != null) {
      menuModel = <MenuModel>[];
      json['menu_list'].forEach((v) {
        menuModel!.add(MenuModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (menuModel != null) {
      data['menu_list'] = menuModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuModel {
  String? menu;

  MenuModel({this.menu});

  MenuModel.fromJson(Map<String, dynamic> json) {
    menu = json['menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu'] = menu;
    return data;
  }
}
