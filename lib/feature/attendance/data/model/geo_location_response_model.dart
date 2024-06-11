import 'dart:convert';

import '../../../../core/core.dart';
import '../../attendance.dart';

class GeoLocationResponseModel extends GeoLocationResponse {
  const GeoLocationResponseModel({
    required super.employeeLogId,
    required super.message,
  });

  const GeoLocationResponseModel.empty()
      : this(
          employeeLogId: 0,
          message: '_empty.message',
        );

  factory GeoLocationResponseModel.fromJson(String source) =>
      GeoLocationResponseModel.fromMap(jsonDecode(source) as DataMap);

  GeoLocationResponseModel.fromMap(DataMap map)
      : this(
          employeeLogId: map['employee_log_id'],
          message: map['message'],
        );

  GeoLocationResponseModel copyWith({
    int? employeeLogId,
    String? message,
  }) {
    return GeoLocationResponseModel(
      employeeLogId: employeeLogId ?? this.employeeLogId,
      message: message ?? this.message,
    );
  }

  DataMap toMap() => {
        'employee_log_id': employeeLogId,
        'message': message,
      };

  String toJson() => jsonEncode(toMap());
}
