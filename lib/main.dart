import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'app/app.dart';
import 'core/core.dart';
import 'feature/feature.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  Logger().d("Title: ${message.notification!.title}");
  Logger().d("Body: ${message.notification!.body}");
}

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ));

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      await init();

      Bloc.observer = AppBlocObserver();

      Future.wait([SharedPrefs.init()]);

      runApp(
        MultiRepositoryProvider(
          providers: repositoryProvider(),
          child: MultiBlocProvider(
            providers: blocProvider(),
            child: const IFiveHrmsApp(),
          ),
        ),
      );
    },
    (error, stack) {},
  );
}

repositoryProvider() {
  return [
    /// Authentication and Auth Repositories
    RepositoryProvider<AuthenticationRepository>(
        create: (context) => sl<AuthenticationRepository>()),
    RepositoryProvider<AuthRepository>(
        create: (context) => sl<AuthRepositoryImpl>()),

    /// Attendance Repositories
    RepositoryProvider<AttendanceRepository>(
        create: (context) => sl<AttendanceRepositoryImpl>()),

    /// Appreciation Repositories
    RepositoryProvider<AppreciationRepository>(
        create: (context) => sl<AppreciationRepositoryImpl>()),

    /// Food Repositories
    RepositoryProvider<FoodRepository>(
        create: (context) => sl<FoodRepositoryImpl>()),

    /// Account Repositories
    RepositoryProvider<AccountRepository>(
        create: (context) => sl<AccountRepositoryImpl>()),

    /// Misspunch Repositories
    RepositoryProvider<MisspunchRepository>(
        create: (context) => sl<MisspunchRepositoryImpl>()),

    /// Leave Repositories
    RepositoryProvider<LeaveRepository>(
        create: (context) => sl<LeaveRepositoryImpl>()),

    /// Payroll Repositories
    RepositoryProvider<PayrollRepository>(
        create: (context) => sl<PayrollRepositoryImpl>()),

    /// ODPermission Repositories
    RepositoryProvider<ODPermissionRepository>(
        create: (context) => sl<ODPermissionRepositoryImpl>()),

    /// Other Service Repositories
    RepositoryProvider<OtherServiceRepository>(
        create: (context) => sl<OtherServiceRepositoryImpl>()),

    /// Expenses Repositories
    RepositoryProvider<ExpensesRepository>(
        create: (context) => sl<ExpensesRepositoryImpl>()),

    /// Sfa Repositories
    RepositoryProvider<SfaRepository>(create: (context) => sl<SfaRepository>()),
  ];
}

blocProvider() {
  return [
    /// Authentication and Auth
    BlocProvider<AuthenticationBloc>(
        create: (context) => sl<AuthenticationBloc>()..add(const AppStarted())),
    BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),

    /// Dashboard and Root
    BlocProvider<PermissionCubit>(create: (context) => sl<PermissionCubit>()),
    BlocProvider<NavigationCubit>(create: (context) => sl<NavigationCubit>()),
    BlocProvider<DashboardCountCubit>(
        create: (context) => sl<DashboardCountCubit>()),
    BlocProvider<DashboardTabBarCubit>(
        create: (context) => sl<DashboardTabBarCubit>()),
    BlocProvider<AttendanceStatusCubit>(
        create: (context) => sl<AttendanceStatusCubit>()),
    BlocProvider<AppreciationCubit>(
        create: (context) => sl<AppreciationCubit>()),
    BlocProvider<GPRSCheckerCubit>(create: (context) => sl<GPRSCheckerCubit>()),
    BlocProvider<AppVersionCheckerCubit>(
        create: (context) => sl<AppVersionCheckerCubit>()),
    BlocProvider<AppreciationCrudBloc>(
        create: (context) => sl<AppreciationCrudBloc>()),
    BlocProvider<RenewalTrackerCubit>(
        create: (context) => sl<RenewalTrackerCubit>()),
    BlocProvider<ApprovalLeaveHistoryCubit>(
        create: (context) => sl<ApprovalLeaveHistoryCubit>()),

    /// Attendance
    BlocProvider<AttendanceBloc>(create: (context) => sl<AttendanceBloc>()),
    BlocProvider<AttendanceReportCubit>(
        create: (context) => sl<AttendanceReportCubit>()),

    /// Food
    BlocProvider<FoodAttendanceBloc>(
        create: (context) => sl<FoodAttendanceBloc>()),
    BlocProvider<FoodAttendanceStatusCubit>(
        create: (context) => sl<FoodAttendanceStatusCubit>()),
    BlocProvider<FoodAttendanceReportCubit>(
        create: (context) => sl<FoodAttendanceReportCubit>()),

    /// Leave
    BlocProvider<LeaveCrudBloc>(create: (context) => sl<LeaveCrudBloc>()),
    BlocProvider<LeaveHistoryCubit>(
        create: (context) => sl<LeaveHistoryCubit>()),
    BlocProvider<LeaveApprovedCubit>(
        create: (context) => sl<LeaveApprovedCubit>()),

    /// Account
    BlocProvider<AccountCrudBloc>(create: (context) => sl<AccountCrudBloc>()),
    BlocProvider<AccountDetailsCubit>(
        create: (context) => sl<AccountDetailsCubit>()),

    /// ODPermission
    BlocProvider<PermissionCrudBloc>(
        create: (context) => sl<PermissionCrudBloc>()),
    BlocProvider<PermissionHistoryCubit>(
        create: (context) => sl<PermissionHistoryCubit>()),
    BlocProvider<PermissionApprovalCubit>(
        create: (context) => sl<PermissionApprovalCubit>()),

    /// Misspunch
    BlocProvider<MisspunchCrudBloc>(
        create: (context) => sl<MisspunchCrudBloc>()),
    BlocProvider<MisspunchApprovedCubit>(
        create: (context) => sl<MisspunchApprovedCubit>()),
    BlocProvider<MisspunchHistoryCubit>(
        create: (context) => sl<MisspunchHistoryCubit>()),

    /// PaySlip
    BlocProvider<PaySlipCubit>(create: (context) => sl<PaySlipCubit>()),
    BlocProvider<PaySlipDocumentCubit>(
        create: (context) => sl<PaySlipDocumentCubit>()),

    /// Task
    BlocProvider<TaskBarCubit>(create: (context) => sl<TaskBarCubit>()),
    BlocProvider<TodayTaskCubit>(create: (context) => sl<TodayTaskCubit>()),
    BlocProvider<StatusBasedTaskCubit>(
        create: (context) => sl<StatusBasedTaskCubit>()),
    BlocProvider<TaskReportCubit>(create: (context) => sl<TaskReportCubit>()),
    BlocProvider<TaskCrudBloc>(create: (context) => sl<TaskCrudBloc>()),

    /// Expenses
    BlocProvider<ExpensesCrudBloc>(create: (context) => sl<ExpensesCrudBloc>()),
    BlocProvider<StatusBasedExpensesCubit>(
        create: (context) => sl<StatusBasedExpensesCubit>()),

    /// Sfa
    BlocProvider<SfaCrudBloc>(create: (context) => sl<SfaCrudBloc>()),
    BlocProvider<NewCallDatabaseBloc>(
        create: (context) => sl<NewCallDatabaseBloc>()),
    BlocProvider<DcrDatabaseBloc>(create: (context) => sl<DcrDatabaseBloc>()),
    BlocProvider<LeadDatabaseBloc>(create: (context) => sl<LeadDatabaseBloc>()),
    BlocProvider<PipelineDatabaseBloc>(
        create: (context) => sl<PipelineDatabaseBloc>()),
  ];
}

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) => super.onCreate(bloc);

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Logger().i('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger().w('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger().w('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger().e('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) => super.onClose(bloc);
}
