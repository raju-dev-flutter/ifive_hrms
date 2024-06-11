// // import 'package:equatable/equatable.dart';
// //
// // class LoginResponse extends Equatable {
// //   // const LoginResponse({
// //   //   required this.employeeId,
// //   //   required this.token,
// //   //   required this.employeeNumber,
// //   //   required this.employeeName,
// //   //   required this.message,
// //   //   required this.departmentId,
// //   // });
// //   //
// //   // const LoginResponse.empty()
// //   //     : this(
// //   //         employeeId: 0,
// //   //         token: '_empty.token',
// //   //         employeeNumber: '_empty.employeeNumber',
// //   //         employeeName: '_empty.employeeName',
// //   //         message: '_empty.message',
// //   //         departmentId: 0,
// //   //       );
// //   //
// //   // final int employeeId;
// //   // final String token;
// //   // final String employeeNumber;
// //   // final String employeeName;
// //   // final String message;
// //   // final int departmentId;
// //   // final int companyId;
// //   //
// //   // @override
// //   // List<Object?> get props =>
// //   //     [employeeId, employeeNumber, employeeName, message, departmentId, token];
// // }
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// @immutable
// class LoginResponse extends Equatable {
//   int? id;
//   int? groupId;
//   String? employeeNumber;
//   String? username;
//   String? firstName;
//   String? lastName;
//   int? employeeId;
//   String? avatar;
//   String? active;
//   String? mActive;
//   int? loginAttempt;
//   dynamic lastLogin;
//   String? imei;
//   String? createdAt;
//   String? updatedAt;
//   dynamic reminder;
//   dynamic activation;
//   int? lastActivity;
//   String? mobileNo;
//   int? reportingManager;
//   String? email;
//   int? orgId;
//   String? locId;
//   int? companyId;
//   String? admindeptId;
//   String? name;
//   String? fcmToken;
//   String? mToken;
//   String? userMail;
//   String? userPassword;
//   int? createdBy;
//   int? lastUpdatedBy;
//   int? empType;
//   String? enableGpsRestriction;
//   String? latitude;
//   String? longtitude;
//   int? meter;
//   String? message;

//   LoginResponse(
//       {this.id,
//       this.groupId,
//       this.employeeNumber,
//       this.username,
//       this.firstName,
//       this.lastName,
//       this.employeeId,
//       this.avatar,
//       this.active,
//       this.mActive,
//       this.loginAttempt,
//       this.lastLogin,
//       this.imei,
//       this.createdAt,
//       this.updatedAt,
//       this.reminder,
//       this.activation,
//       this.lastActivity,
//       this.mobileNo,
//       this.reportingManager,
//       this.email,
//       this.orgId,
//       this.locId,
//       this.companyId,
//       this.admindeptId,
//       this.name,
//       this.fcmToken,
//       this.mToken,
//       this.userMail,
//       this.userPassword,
//       this.createdBy,
//       this.lastUpdatedBy,
//       this.empType,
//       this.enableGpsRestriction,
//       this.latitude,
//       this.longtitude,
//       this.meter,
//       this.message});

//   @override
//   List<Object?> get props => [
//         id,
//         groupId,
//         employeeNumber,
//         username,
//         firstName,
//         lastName,
//         employeeId,
//         avatar,
//         active,
//         mActive,
//         loginAttempt,
//         lastLogin,
//         imei,
//         createdAt,
//         updatedAt,
//         reminder,
//         activation,
//         lastActivity,
//         mobileNo,
//         reportingManager,
//         email,
//         orgId,
//         locId,
//         companyId,
//         admindeptId,
//         name,
//         fcmToken,
//         mToken,
//         userMail,
//         userPassword,
//         createdBy,
//         lastUpdatedBy,
//         empType,
//         enableGpsRestriction,
//         latitude,
//         longtitude,
//         meter,
//         message
//       ];

//   // LoginResponse.fromJson(Map<String, dynamic> json) {
//   //   id = json['id'];
//   //   groupId = json['group_id'];
//   //   employeeNumber = json['employee_number'];
//   //   username = json['username'];
//   //   firstName = json['first_name'];
//   //   lastName = json['last_name'];
//   //   employeeId = json['employee_id'];
//   //   avatar = json['avatar'];
//   //   active = json['active'];
//   //   mActive = json['m_active'];
//   //   loginAttempt = json['login_attempt'];
//   //   lastLogin = json['last_login'];
//   //   imei = json['imei'];
//   //   createdAt = json['created_at'];
//   //   updatedAt = json['updated_at'];
//   //   reminder = json['reminder'];
//   //   activation = json['activation'];
//   //   lastActivity = json['last_activity'];
//   //   mobileNo = json['mobile_no'];
//   //   reportingManager = json['reporting_manager'];
//   //   email = json['email'];
//   //   orgId = json['org_id'];
//   //   locId = json['loc_id'];
//   //   companyId = json['company_id'];
//   //   admindeptId = json['admindept_id'];
//   //   name = json['name'];
//   //   fcmToken = json['fcm_token'];
//   //   mToken = json['m_token'];
//   //   userMail = json['user_mail'];
//   //   userPassword = json['user_password'];
//   //   createdBy = json['created_by'];
//   //   lastUpdatedBy = json['last_updated_by'];
//   //   empType = json['emp_type'];
//   //   enableGpsRestriction = json['enable_gps_restriction'];
//   //   latitude = json['latitude'];
//   //   longtitude = json['longtitude'];
//   //   meter = json['meter'];
//   //   message = json['message'];
//   // }
//   //
//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['id'] = this.id;
//   //   data['group_id'] = this.groupId;
//   //   data['employee_number'] = this.employeeNumber;
//   //   data['username'] = this.username;
//   //   data['first_name'] = this.firstName;
//   //   data['last_name'] = this.lastName;
//   //   data['employee_id'] = this.employeeId;
//   //   data['avatar'] = this.avatar;
//   //   data['active'] = this.active;
//   //   data['m_active'] = this.mActive;
//   //   data['login_attempt'] = this.loginAttempt;
//   //   data['last_login'] = this.lastLogin;
//   //   data['imei'] = this.imei;
//   //   data['created_at'] = this.createdAt;
//   //   data['updated_at'] = this.updatedAt;
//   //   data['reminder'] = this.reminder;
//   //   data['activation'] = this.activation;
//   //   data['last_activity'] = this.lastActivity;
//   //   data['mobile_no'] = this.mobileNo;
//   //   data['reporting_manager'] = this.reportingManager;
//   //   data['email'] = this.email;
//   //   data['org_id'] = this.orgId;
//   //   data['loc_id'] = this.locId;
//   //   data['company_id'] = this.companyId;
//   //   data['admindept_id'] = this.admindeptId;
//   //   data['name'] = this.name;
//   //   data['fcm_token'] = this.fcmToken;
//   //   data['m_token'] = this.mToken;
//   //   data['user_mail'] = this.userMail;
//   //   data['user_password'] = this.userPassword;
//   //   data['created_by'] = this.createdBy;
//   //   data['last_updated_by'] = this.lastUpdatedBy;
//   //   data['emp_type'] = this.empType;
//   //   data['enable_gps_restriction'] = this.enableGpsRestriction;
//   //   data['latitude'] = this.latitude;
//   //   data['longtitude'] = this.longtitude;
//   //   data['meter'] = this.meter;
//   //   data['message'] = this.message;
//   //   return data;
//   // }
// }
