import 'package:flutter/material.dart';

import '../../feature/feature.dart';
import '../config.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      ///* ========= Profile Route ========= *\\\
      case AppRouterPath.profileEditScreen:
        final arg = settings.arguments as ProfileEditScreen;
        return MaterialPageRoute(
            builder: (_) => ProfileEditScreen(profile: arg.profile));

      case AppRouterPath.profileUpdateOfficeScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileUpdateOfficeScreen());

      case AppRouterPath.profilePersonalDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfilePersonalDetailsScreen());

      case AppRouterPath.profileUpdatePersonalScreen:
        final arg = settings.arguments as ProfileUpdatePersonalScreen;
        return MaterialPageRoute(
            builder: (_) =>
                ProfileUpdatePersonalScreen(personal: arg.personal));

      case AppRouterPath.profileUpdateContactScreen:
        final arg = settings.arguments as ProfileUpdateContactScreen;
        return MaterialPageRoute(
            builder: (_) => ProfileUpdateContactScreen(contact: arg.contact));

      case AppRouterPath.profileContactDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileContactDetailsScreen());

      case AppRouterPath.profileUpdateBankScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileUpdateBankScreen());

      case AppRouterPath.profileUpdateEducationScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileUpdateEducationScreen());

      case AppRouterPath.profileUpdateExperienceScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileUpdateExperienceScreen());

      case AppRouterPath.profileUpdateSkillsScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileUpdateSkillsScreen());

      case AppRouterPath.profileUpdateTrainingCertificationScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileUpdateTrainingCertificationScreen());

      case AppRouterPath.profileUpdateVisaImmigrationScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileUpdateVisaImmigrationScreen());

      ///* ========= Attendance Route ========= *\\\
      case AppRouterPath.attendance:
        return MaterialPageRoute(builder: (_) => const AttendanceScreen());

      case AppRouterPath.attendanceReport:
        return MaterialPageRoute(
            builder: (_) => const AttendanceReportScreen());

      case AppRouterPath.attendanceEmployeeDetailScreen:
        final arg = settings.arguments as AttendanceEmployeeDetailScreen;
        return MaterialPageRoute(
            builder: (_) =>
                AttendanceEmployeeDetailScreen(attendance: arg.attendance));

      ///* ========= Food Attendance Route ========= *\\\
      case AppRouterPath.foodAttendance:
        return MaterialPageRoute(builder: (_) => const FoodAttendanceScreen());

      case AppRouterPath.foodAttendanceReport:
        return MaterialPageRoute(
            builder: (_) => const FoodAttendanceReportScreen());

      ///* ========= Leave Route ========= *\\\
      case AppRouterPath.leaveRequest:
        return MaterialPageRoute(builder: (_) => const LeaveRequestScreen());

      case AppRouterPath.leaveHistory:
        return MaterialPageRoute(builder: (_) => const LeaveHistoryScreen());

      case AppRouterPath.leaveCancel:
        final arg = settings.arguments as LeaveCancelScreen;
        return MaterialPageRoute(
            builder: (_) => LeaveCancelScreen(leave: arg.leave));

      case AppRouterPath.leaveUpdate:
        final arg = settings.arguments as LeaveUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => LeaveUpdateScreen(leave: arg.leave));

      case AppRouterPath.leaveScreen:
        return MaterialPageRoute(builder: (_) => const LeaveScreen());

      case AppRouterPath.leaveApproval:
        return MaterialPageRoute(builder: (_) => const LeaveApprovalScreen());

      ///* ========= Misspunch Route ========= *\\\
      case AppRouterPath.misspunchRequest:
        return MaterialPageRoute(
            builder: (_) => const MisspunchRequestScreen());

      case AppRouterPath.misspunch:
        return MaterialPageRoute(builder: (_) => const MisspunchScreen());

      case AppRouterPath.misspunchCancel:
        final arg = settings.arguments as MisspunchCancelScreen;
        return MaterialPageRoute(
            builder: (_) => MisspunchCancelScreen(missPunch: arg.missPunch));

      case AppRouterPath.misspunchUpdate:
        final arg = settings.arguments as MisspunchUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => MisspunchUpdateScreen(missPunch: arg.missPunch));

      ///* ========= OD Permission Route ========= *\\\
      case AppRouterPath.oDPermissionRequestScreen:
        return MaterialPageRoute(
            builder: (_) => const ODPermissionRequestScreen());

      case AppRouterPath.oDPermissionScreen:
        return MaterialPageRoute(builder: (_) => const ODPermissionScreen());

      case AppRouterPath.oDPermissionUpdateScreen:
        final arg = settings.arguments as ODPermissionUpdateScreen;
        return MaterialPageRoute(
            builder: (_) =>
                ODPermissionUpdateScreen(permission: arg.permission));

      case AppRouterPath.oDPermissionCancelScreen:
        final arg = settings.arguments as ODPermissionCancelScreen;
        return MaterialPageRoute(
            builder: (_) =>
                ODPermissionCancelScreen(permission: arg.permission));

      ///* ========= Payroll Route ========= *\\\

      case AppRouterPath.payrollScreen:
        return MaterialPageRoute(builder: (_) => const PayrollScreen());

      case AppRouterPath.payrollDetailsScreen:
        final arg = settings.arguments as PayrollDetailsScreen;
        return MaterialPageRoute(
            builder: (_) => PayrollDetailsScreen(paySlipId: arg.paySlipId));

      ///* ========= SFA Route ========= *\\\

      case AppRouterPath.generateTicketScreen:
        return MaterialPageRoute(builder: (_) => const GenerateTicketScreen());

      case AppRouterPath.databaseUpdateScreen:
        final arg = settings.arguments as DatabaseUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => DatabaseUpdateScreen(database: arg.database));

      case AppRouterPath.newCallDatabaseUpdateScreen:
        final arg = settings.arguments as NewCallDatabaseUpdateScreen;
        return MaterialPageRoute(
            builder: (_) =>
                NewCallDatabaseUpdateScreen(database: arg.database));

      case AppRouterPath.dcrDatabaseUpdateScreen:
        final arg = settings.arguments as DcrDatabaseUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => DcrDatabaseUpdateScreen(database: arg.database));

      case AppRouterPath.leadDatabaseUpdateScreen:
        final arg = settings.arguments as LeadDatabaseUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => LeadDatabaseUpdateScreen(database: arg.database));

      case AppRouterPath.pipelineDatabaseUpdateScreen:
        final arg = settings.arguments as PipelineDatabaseUpdateScreen;
        return MaterialPageRoute(
            builder: (_) =>
                PipelineDatabaseUpdateScreen(database: arg.database));

      ///* ========= Expenses Route ========= *\\\

      case AppRouterPath.expensesScreen:
        return MaterialPageRoute(builder: (_) => const ExpensesScreen());

      case AppRouterPath.expensesRequestScreen:
        return MaterialPageRoute(builder: (_) => const ExpensesRequestScreen());

      case AppRouterPath.expensesUpdateScreen:
        final arg = settings.arguments as ExpensesUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => ExpensesUpdateScreen(expenses: arg.expenses));

      case AppRouterPath.expensesDetailsScreen:
        final arg = settings.arguments as ExpensesDetailsScreen;
        return MaterialPageRoute(
            builder: (_) => ExpensesDetailsScreen(expenses: arg.expenses));

      ///* ========= Project Task Route ========= *\\\

      case AppRouterPath.projectTaskRequestScreen:
        return MaterialPageRoute(
            builder: (_) => const ProjectTaskRequestScreen());

      case AppRouterPath.projectTaskApprovalScreen:
        return MaterialPageRoute(
            builder: (_) => const ProjectTaskApprovalScreen());

      case AppRouterPath.projectTaskApprovalFormScreen:
        final arg = settings.arguments as ProjectTaskApprovalFormScreen;
        return MaterialPageRoute(
            builder: (_) => ProjectTaskApprovalFormScreen(task: arg.task));

      case AppRouterPath.projectTaskUpdateScreen:
        return MaterialPageRoute(
            builder: (_) => const ProjectTaskUpdateScreen());

      case AppRouterPath.projectTaskUpdateFormScreen:
        final arg = settings.arguments as ProjectTaskUpdateFormScreen;
        return MaterialPageRoute(
            builder: (_) => ProjectTaskUpdateFormScreen(task: arg.task));

      ///* ========= Task Route ========= *\\\

      case AppRouterPath.taskCreatedScreen:
        return MaterialPageRoute(builder: (_) => const TaskCreatedScreen());

      case AppRouterPath.taskCreatedUpdateScreen:
        final arg = settings.arguments as TaskCreatedUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => TaskCreatedUpdateScreen(task: arg.task));

      case AppRouterPath.taskInitiatedScreen:
        return MaterialPageRoute(builder: (_) => const TaskInitiatedScreen());

      case AppRouterPath.taskInitiatedUpdateScreen:
        final arg = settings.arguments as TaskInitiatedUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => TaskInitiatedUpdateScreen(task: arg.task));

      case AppRouterPath.taskPendingScreen:
        return MaterialPageRoute(builder: (_) => const TaskPendingScreen());

      case AppRouterPath.taskPendingUpdateScreen:
        final arg = settings.arguments as TaskPendingUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => TaskPendingUpdateScreen(task: arg.task));

      case AppRouterPath.taskInProgressScreen:
        return MaterialPageRoute(builder: (_) => const TaskInProgressScreen());

      case AppRouterPath.taskInProgressUpdateScreen:
        final arg = settings.arguments as TaskInProgressUpdateScreen;
        return MaterialPageRoute(
            builder: (_) => TaskInProgressUpdateScreen(task: arg.task));

      case AppRouterPath.taskTestL1Screen:
        return MaterialPageRoute(builder: (_) => const TaskTestL1Screen());

      case AppRouterPath.taskTestL1UpdateScreen:
        final arg = settings.arguments as TaskTestL1UpdateScreen;
        return MaterialPageRoute(
            builder: (_) => TaskTestL1UpdateScreen(task: arg.task));

      case AppRouterPath.taskTestL2Screen:
        return MaterialPageRoute(builder: (_) => const TaskTestL2Screen());

      case AppRouterPath.taskTestL2UpdateScreen:
        final arg = settings.arguments as TaskTestL2UpdateScreen;
        return MaterialPageRoute(
            builder: (_) => TaskTestL2UpdateScreen(task: arg.task));

      case AppRouterPath.taskCompletedScreen:
        return MaterialPageRoute(builder: (_) => const TaskCompletedScreen());

      case AppRouterPath.taskCompletedDetailScreen:
        final arg = settings.arguments as TaskCompletedDetailScreen;
        return MaterialPageRoute(
            builder: (_) => TaskCompletedDetailScreen(task: arg.task));

      case AppRouterPath.createSupportTaskScreen:
        // final arg = settings.arguments as TaskCompletedDetailScreen;
        return MaterialPageRoute(
            builder: (_) => const CreateSupportTaskScreen());

      ///* ========= Change Password Route ========= *\\\

      case AppRouterPath.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      ///* ========= Appreciation Route ========= *\\\

      case AppRouterPath.appreciationScreen:
        return MaterialPageRoute(builder: (_) => const AppreciationScreen());

      ///* ========= gallery Route ========= *\\\

      case AppRouterPath.galleryScreen:
        return MaterialPageRoute(builder: (_) => const GalleryScreen());

      ///* ========= Renewal Tracking Route ========= *\\\

      case AppRouterPath.renewalTrackingScreen:
        return MaterialPageRoute(builder: (_) => const RenewalTrackingScreen());

      ///* ========= Dashboard Leave Approval Route ========= *\\\

      case AppRouterPath.dashboardLeaveApprovalScreen:
        return MaterialPageRoute(
            builder: (_) => const DashboardLeaveApprovalScreen());

      case AppRouterPath.leadTaskScreen:
        return MaterialPageRoute(builder: (_) => const LeadTaskScreen());

      ///* ========= Asset Management Route ========= *\\\

      case AppRouterPath.assetManagementScreen:
        return MaterialPageRoute(builder: (_) => const AssetManagementScreen());

      ///* ========= Database Camera Route ========= *\\\

      case AppRouterPath.databaseCameraScreen:
        return MaterialPageRoute(builder: (_) => const DatabaseCameraScreen());

      ///* ========= Tour Plan Route ========= *\\\

      case AppRouterPath.tourPlanRequestScreen:
        return MaterialPageRoute(builder: (_) => const TourPlanRequestScreen());

      case AppRouterPath.tourPlanApprovalScreen:
        return MaterialPageRoute(
            builder: (_) => const TourPlanApprovalScreen());

      case AppRouterPath.tourPlanApprovalFormScreen:
        return MaterialPageRoute(
            builder: (_) => const TourPlanApprovalFormScreen());

      ///* ========= Chat Route ========= *\\\

      case AppRouterPath.chatContactScreen:
        return MaterialPageRoute(builder: (_) => const ChatContactScreen());

      case AppRouterPath.chatMessageScreen:
        final arg = settings.arguments as ChatMessageScreen;
        return MaterialPageRoute(
            builder: (_) => ChatMessageScreen(contact: arg.contact));

      ///* ========= No Route view ========= *\\\

      case AppRouterPath.noRoute:
        return MaterialPageRoute(builder: (_) => const UnknownScreen());
      default:
        return MaterialPageRoute(builder: (_) => const UnknownScreen());
    }
  }
}
