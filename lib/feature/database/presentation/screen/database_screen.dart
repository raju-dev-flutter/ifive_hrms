import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../account/account.dart';
import '../../../dashboard/dashboard.dart';
import '../../database.dart';

class DatabaseScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;

  const DatabaseScreen({super.key, required this.scaffold});

  @override
  State<DatabaseScreen> createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  @override
  void initState() {
    super.initState();
    Logger().i("User Token: ${SharedPrefs().getToken()}");
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    final token = SharedPrefs().getToken();
    BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
        .getAttendanceStatus(token);
    BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: BlocListener<AttendanceStatusCubit, AttendanceStatusState>(
        listener: (context, state) {
          if (state is AttendanceStatusFailed) {
            if (state.message == "Invalid Token") {
              BlocProvider.of<AuthenticationBloc>(context, listen: false)
                  .add(const LoggedOut());
            }
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: 110.h,
              child: DashboardHeaderWidget(
                scaffold: widget.scaffold,
                actionWidget: IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, AppRouterPath.generateTicketScreen),
                  icon: Icon(Icons.add, color: appColor.white),
                ),
              ),
            ),
            TabBar(
              padding: const EdgeInsets.only(top: 6).w,
              labelStyle: context.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
              unselectedLabelStyle: context.textTheme.labelLarge,
              labelColor: appColor.blue600,
              unselectedLabelColor: appColor.gray500,
              tabs: const [
                Tab(icon: Text('New Call')),
                Tab(icon: Text('DCR')),
                Tab(icon: Text('Lead')),
                Tab(icon: Text('Pipeline')),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  NewCallDatabaseScreen(),
                  DcrDatabaseScreen(),
                  LeadDatabaseScreen(),
                  PipelineDatabaseScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
