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
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await ApiUrl.initializeBaseUrl();

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
}

repositoryProvider() {
  return [
    /// Authentication and Auth Repositories
    RepositoryProvider<AuthenticationRepository>(
        create: (ctx) => sl<AuthenticationRepository>()),
    RepositoryProvider<AuthRepository>(
        create: (ctx) => sl<AuthRepositoryImpl>()),

    /// Attendance Repositories
    RepositoryProvider<AttendanceRepository>(
        create: (ctx) => sl<AttendanceRepositoryImpl>()),

    /// Appreciation Repositories
    RepositoryProvider<AppreciationRepository>(
        create: (ctx) => sl<AppreciationRepositoryImpl>()),

    /// Food Repositories
    RepositoryProvider<FoodRepository>(
        create: (ctx) => sl<FoodRepositoryImpl>()),

    /// Account Repositories
    RepositoryProvider<AccountRepository>(
        create: (ctx) => sl<AccountRepositoryImpl>()),

    /// Misspunch Repositories
    RepositoryProvider<MisspunchRepository>(
        create: (ctx) => sl<MisspunchRepositoryImpl>()),

    /// Leave Repositories
    RepositoryProvider<LeaveRepository>(
        create: (ctx) => sl<LeaveRepositoryImpl>()),

    /// Payroll Repositories
    RepositoryProvider<PayrollRepository>(
        create: (ctx) => sl<PayrollRepositoryImpl>()),

    /// ODPermission Repositories
    RepositoryProvider<ODPermissionRepository>(
        create: (ctx) => sl<ODPermissionRepositoryImpl>()),

    /// Other Service Repositories
    RepositoryProvider<OtherServiceRepository>(
        create: (ctx) => sl<OtherServiceRepositoryImpl>()),

    /// Expenses Repositories
    RepositoryProvider<ExpensesRepository>(
        create: (ctx) => sl<ExpensesRepositoryImpl>()),

    /// Task Repositories
    RepositoryProvider<TaskRepository>(
        create: (ctx) => sl<TaskRepositoryImpl>()),

    /// ProjectTask Repositories
    RepositoryProvider<ProjectTaskRepository>(
        create: (ctx) => sl<ProjectTaskRepositoryImpl>()),

    /// Sfa Repositories
    RepositoryProvider<SfaRepository>(create: (ctx) => sl<SfaRepositoryImpl>()),

    /// Chat Repositories
    RepositoryProvider<ChatRepository>(
        create: (ctx) => sl<ChatRepositoryImpl>()),

    /// Backup Repositories
    RepositoryProvider<BackupRepository>(
        create: (ctx) => sl<BackupRepositoryImpl>()),

    /// TourPlan Repositories
    RepositoryProvider<TourPlanRepository>(
        create: (ctx) => sl<TourPlanRepositoryImpl>()),
  ];
}

blocProvider() {
  return [
    /// Authentication and Auth
    BlocProvider<AuthenticationBloc>(
        create: (ctx) => sl<AuthenticationBloc>()..add(const AppStarted())),
    BlocProvider<AuthBloc>(create: (ctx) => sl<AuthBloc>()),

    /// Dashboard and Root
    BlocProvider<PermissionCubit>(create: (ctx) => sl<PermissionCubit>()),
    BlocProvider<NavigationCubit>(create: (ctx) => sl<NavigationCubit>()),
    BlocProvider<DashboardCountCubit>(
        create: (ctx) => sl<DashboardCountCubit>()),
    BlocProvider<DashboardTabBarCubit>(
        create: (ctx) => sl<DashboardTabBarCubit>()),
    BlocProvider<TaskLeadCubit>(create: (ctx) => sl<TaskLeadCubit>()),
    BlocProvider<AttendanceStatusCubit>(
        create: (ctx) => sl<AttendanceStatusCubit>()),
    BlocProvider<AppreciationCubit>(create: (ctx) => sl<AppreciationCubit>()),
    BlocProvider<GPRSCheckerCubit>(create: (ctx) => sl<GPRSCheckerCubit>()),
    BlocProvider<AppVersionCheckerCubit>(
        create: (ctx) => sl<AppVersionCheckerCubit>()),
    BlocProvider<AppreciationCrudBloc>(
        create: (ctx) => sl<AppreciationCrudBloc>()),
    BlocProvider<RenewalTrackerCubit>(
        create: (ctx) => sl<RenewalTrackerCubit>()),
    BlocProvider<ApprovalLeaveHistoryCubit>(
        create: (ctx) => sl<ApprovalLeaveHistoryCubit>()),

    /// Attendance
    BlocProvider<AttendanceBloc>(create: (ctx) => sl<AttendanceBloc>()),
    BlocProvider<AttendanceReportCubit>(
        create: (ctx) => sl<AttendanceReportCubit>()),

    /// Food
    BlocProvider<FoodAttendanceBloc>(create: (ctx) => sl<FoodAttendanceBloc>()),
    BlocProvider<FoodAttendanceStatusCubit>(
        create: (ctx) => sl<FoodAttendanceStatusCubit>()),
    BlocProvider<FoodAttendanceReportCubit>(
        create: (ctx) => sl<FoodAttendanceReportCubit>()),

    /// Leave
    BlocProvider<LeaveCrudBloc>(create: (ctx) => sl<LeaveCrudBloc>()),
    BlocProvider<LeaveHistoryCubit>(create: (ctx) => sl<LeaveHistoryCubit>()),
    BlocProvider<LeaveApprovedCubit>(create: (ctx) => sl<LeaveApprovedCubit>()),

    /// Account
    BlocProvider<AccountCrudBloc>(create: (ctx) => sl<AccountCrudBloc>()),
    BlocProvider<AccountDetailsCubit>(
        create: (ctx) => sl<AccountDetailsCubit>()),

    /// ODPermission
    BlocProvider<PermissionCrudBloc>(create: (ctx) => sl<PermissionCrudBloc>()),
    BlocProvider<PermissionHistoryCubit>(
        create: (ctx) => sl<PermissionHistoryCubit>()),
    BlocProvider<PermissionApprovalCubit>(
        create: (ctx) => sl<PermissionApprovalCubit>()),

    /// Misspunch
    BlocProvider<MisspunchCrudBloc>(create: (ctx) => sl<MisspunchCrudBloc>()),
    BlocProvider<MisspunchApprovedCubit>(
        create: (ctx) => sl<MisspunchApprovedCubit>()),
    BlocProvider<MisspunchHistoryCubit>(
        create: (ctx) => sl<MisspunchHistoryCubit>()),

    /// PaySlip
    BlocProvider<PaySlipCubit>(create: (ctx) => sl<PaySlipCubit>()),
    BlocProvider<PaySlipDocumentCubit>(
        create: (ctx) => sl<PaySlipDocumentCubit>()),

    /// Task
    BlocProvider<TaskBarCubit>(create: (ctx) => sl<TaskBarCubit>()),
    BlocProvider<TodayTaskCubit>(create: (ctx) => sl<TodayTaskCubit>()),
    BlocProvider<StatusBasedTaskCubit>(
        create: (ctx) => sl<StatusBasedTaskCubit>()),
    BlocProvider<TaskReportCubit>(create: (ctx) => sl<TaskReportCubit>()),
    BlocProvider<TaskCrudBloc>(create: (ctx) => sl<TaskCrudBloc>()),

    /// Project Task
    BlocProvider<ProjectTaskCrudBloc>(
        create: (ctx) => sl<ProjectTaskCrudBloc>()),
    BlocProvider<CommonProjectTaskBloc>(
        create: (ctx) => sl<CommonProjectTaskBloc>()),

    /// Expenses
    BlocProvider<ExpensesCrudBloc>(create: (ctx) => sl<ExpensesCrudBloc>()),
    BlocProvider<StatusBasedExpensesCubit>(
        create: (ctx) => sl<StatusBasedExpensesCubit>()),

    /// Sfa
    BlocProvider<SfaCrudBloc>(create: (ctx) => sl<SfaCrudBloc>()),
    BlocProvider<NewCallDatabaseBloc>(
        create: (ctx) => sl<NewCallDatabaseBloc>()),
    BlocProvider<DcrDatabaseBloc>(create: (ctx) => sl<DcrDatabaseBloc>()),
    BlocProvider<LeadDatabaseBloc>(create: (ctx) => sl<LeadDatabaseBloc>()),
    BlocProvider<CommonDatabaseBloc>(create: (ctx) => sl<CommonDatabaseBloc>()),
    BlocProvider<PipelineDatabaseBloc>(
        create: (ctx) => sl<PipelineDatabaseBloc>()),

    /// Chat
    BlocProvider<ChatContactCubit>(create: (ctx) => sl<ChatContactCubit>()),
    BlocProvider<MessageContentCubit>(
        create: (ctx) => sl<MessageContentCubit>()),
    BlocProvider<ChatCrudBloc>(create: (ctx) => sl<ChatCrudBloc>()),

    /// TourPlan
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
