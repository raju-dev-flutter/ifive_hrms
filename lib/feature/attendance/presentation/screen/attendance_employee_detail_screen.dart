import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../attendance.dart';

class AttendanceEmployeeDetailScreen extends StatefulWidget {
  final UserList attendance;

  const AttendanceEmployeeDetailScreen({super.key, required this.attendance});

  @override
  State<AttendanceEmployeeDetailScreen> createState() =>
      _AttendanceEmployeeDetailScreenState();
}

class _AttendanceEmployeeDetailScreenState
    extends State<AttendanceEmployeeDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialCallBack(DateFormat('dd-MM-yyyy').format(selectedDate));
  }

  Future<void> initialCallBack(String date) async {
    BlocProvider.of<AttendanceReportCubit>(context, listen: false)
        .grtAttendanceReportList(
            DateFormat('dd-MM-yyyy').format(DateTime.now()),
            widget.attendance.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: widget.attendance.firstName ?? "",
        ),
      ),
      body: const AttendanceLogCard(),
    );
  }
}
