class LoginResponseModel {
  int? id;
  int? groupId;
  String? employeeNumber;
  String? username;
  String? firstName;
  String? lastName;
  int? employeeId;
  String? avatar;
  String? active;
  String? mActive;
  int? loginAttempt;
  String? lastLogin;
  String? imei;
  String? createdAt;
  String? updatedAt;
  String? reminder;
  String? activation;
  int? lastActivity;
  String? mobileNo;
  int? reportingManager;
  String? email;
  int? orgId;
  String? locId;
  int? companyId;
  String? admindeptId;
  String? name;
  String? fcmToken;
  String? mToken;
  String? userMail;
  String? userPassword;
  int? createdBy;
  int? lastUpdatedBy;
  int? empType;
  String? enableGpsRestriction;
  String? latitude;
  String? longtitude;
  int? meter;
  String? cameraQuality;
  MenuList? menuList;
  String? message;

  LoginResponseModel(
      {this.id,
      this.groupId,
      this.employeeNumber,
      this.username,
      this.firstName,
      this.lastName,
      this.employeeId,
      this.avatar,
      this.active,
      this.mActive,
      this.loginAttempt,
      this.lastLogin,
      this.imei,
      this.createdAt,
      this.updatedAt,
      this.reminder,
      this.activation,
      this.lastActivity,
      this.mobileNo,
      this.reportingManager,
      this.email,
      this.orgId,
      this.locId,
      this.companyId,
      this.admindeptId,
      this.name,
      this.fcmToken,
      this.mToken,
      this.userMail,
      this.userPassword,
      this.createdBy,
      this.lastUpdatedBy,
      this.empType,
      this.enableGpsRestriction,
      this.latitude,
      this.longtitude,
      this.meter,
      this.cameraQuality,
      this.menuList,
      this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    employeeNumber = json['employee_number'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    employeeId = json['employee_id'];
    avatar = json['avatar'];
    active = json['active'];
    mActive = json['m_active'];
    loginAttempt = json['login_attempt'];
    lastLogin = json['last_login'];
    imei = json['imei'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reminder = json['reminder'];
    activation = json['activation'];
    lastActivity = json['last_activity'];
    mobileNo = json['mobile_no'];
    reportingManager = json['reporting_manager'];
    email = json['email'];
    orgId = json['org_id'];
    locId = json['loc_id'];
    companyId = json['company_id'];
    admindeptId = json['admindept_id'];
    name = json['name'];
    fcmToken = json['fcm_token'];
    mToken = json['m_token'];
    userMail = json['user_mail'];
    userPassword = json['user_password'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    empType = json['emp_type'];
    enableGpsRestriction = json['enable_gps_restriction'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    meter = json['meter'];
    cameraQuality = json['camera_quality'];
    menuList =
        json['menu_list'] != null ? MenuList.fromJson(json['menu_list']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_id'] = groupId;
    data['employee_number'] = employeeNumber;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['employee_id'] = employeeId;
    data['avatar'] = avatar;
    data['active'] = active;
    data['m_active'] = mActive;
    data['login_attempt'] = loginAttempt;
    data['last_login'] = lastLogin;
    data['imei'] = imei;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['reminder'] = reminder;
    data['activation'] = activation;
    data['last_activity'] = lastActivity;
    data['mobile_no'] = mobileNo;
    data['reporting_manager'] = reportingManager;
    data['email'] = email;
    data['org_id'] = orgId;
    data['loc_id'] = locId;
    data['company_id'] = companyId;
    data['admindept_id'] = admindeptId;
    data['name'] = name;
    data['fcm_token'] = fcmToken;
    data['m_token'] = mToken;
    data['user_mail'] = userMail;
    data['user_password'] = userPassword;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['emp_type'] = empType;
    data['enable_gps_restriction'] = enableGpsRestriction;
    data['latitude'] = latitude;
    data['longtitude'] = longtitude;
    data['meter'] = meter;
    data['camera_quality'] = cameraQuality;
    if (menuList != null) {
      data['menu_list'] = menuList!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class MenuList {
  String? menu;

  MenuList({this.menu});

  MenuList.fromJson(Map<String, dynamic> json) {
    menu = json['menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu'] = menu;
    return data;
  }
}
