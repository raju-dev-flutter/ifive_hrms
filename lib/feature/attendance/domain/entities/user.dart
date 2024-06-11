import 'package:equatable/equatable.dart';

class AttendanceUser extends Equatable {
  final int? employeeId;
  final String? firstName;
  final int? id;
  final String? active;
  final int? type;
  final String? sTime;
  final String? taskDescription;
  final String? sTimestamp;
  final String? eTimestamp;
  final String? timeTaken;

  const AttendanceUser({
    required this.employeeId,
    required this.firstName,
    required this.id,
    required this.active,
    required this.type,
    required this.sTime,
    required this.taskDescription,
    required this.sTimestamp,
    required this.eTimestamp,
    required this.timeTaken,
  });

  const AttendanceUser.empty()
      : this(
          employeeId: 0,
          firstName: "_empty.firstName",
          id: 0,
          active: "_empty.active",
          type: 0,
          sTime: "_empty.sType",
          taskDescription: "_empty.taskDescription",
          sTimestamp: "_empty.sTimestamp",
          eTimestamp: "_empty.eTimestamp",
          timeTaken: "_empty.timeTaken",
        );

  @override
  List<Object?> get props => [
        employeeId,
        firstName,
        id,
        active,
        type,
        sTime,
        taskDescription,
        sTimestamp,
        eTimestamp,
        timeTaken,
      ];
}
