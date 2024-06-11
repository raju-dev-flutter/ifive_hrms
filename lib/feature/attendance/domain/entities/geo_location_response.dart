import 'package:equatable/equatable.dart';

class GeoLocationResponse extends Equatable {
  final int? employeeLogId;
  final String? message;

  const GeoLocationResponse(
      {required this.employeeLogId, required this.message});

  const GeoLocationResponse.empty()
      : this(employeeLogId: 0, message: "_empty.message");

  @override
  List<Object?> get props => [employeeLogId, message];
}
