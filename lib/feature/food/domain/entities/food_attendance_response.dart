import 'package:equatable/equatable.dart';

class FoodAttendanceResponse extends Equatable {
  final String? message;
  final String? createdAt;

  const FoodAttendanceResponse(
      {required this.message, required this.createdAt});

  const FoodAttendanceResponse.empty()
      : this(message: "_empty.message", createdAt: "_empty.createdAt");

  @override
  List<Object?> get props => [message, createdAt];
}
