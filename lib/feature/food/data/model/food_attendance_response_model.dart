import 'dart:convert';

import '../../../../core/core.dart';
import '../../../feature.dart';

class FoodAttendanceResponseModel extends FoodAttendanceResponse {
  const FoodAttendanceResponseModel(
      {required super.message, required super.createdAt});

  factory FoodAttendanceResponseModel.fromJson(String source) =>
      FoodAttendanceResponseModel.fromMap(jsonDecode(source) as DataMap);

  FoodAttendanceResponseModel.fromMap(DataMap map)
      : this(message: map['message'], createdAt: map['created_at']);

  FoodAttendanceResponseModel copyWith({
    String? message,
    String? createdAt,
  }) {
    return FoodAttendanceResponseModel(
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt);
  }

  DataMap toMap() => {'message': message, 'created_at': createdAt};

  String toJson() => jsonEncode(toMap());
}
