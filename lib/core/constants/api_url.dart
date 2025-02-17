import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';

class ApiUrl {
  // static const String baseUrl = "https://i5erp.in/i5smarthr/";
  static String baseUrl = '';

  // Initialize base URL from Firebase Realtime Database
  static Future<void> initializeBaseUrl() async {
    try {
      final DatabaseReference database = FirebaseDatabase.instance.ref();
      final snapshot = await database.child('app-base-url').get();

      if (snapshot.exists) {
        Map response = snapshot.value as Map;
        final res = response['ifive_hrms'] as Map;
        if (res['mode'] == "prod") {
          baseUrl = res['prod'] ?? '';
        } else if (res['mode'] == "dev") {
          baseUrl = res['dev'] ?? '';
        } else {
          baseUrl = res['demo'] ?? '';
        }
        Logger().i('Base URL initialized: $baseUrl');
      } else {
        Logger().w('Snapshot does not exist.');
        throw Exception("Base URL not found in Firebase.");
      }
    } catch (e) {
      Logger().e('Error initializing base URL: $e');
      rethrow;
    }
  }

  /// Get API Endpoint
  static String getBaseUrl(String endpointPath) {
    initializeBaseUrl();
    if (baseUrl.isEmpty) {
      return '';
    }
    return "$baseUrl/$endpointPath";
  }

  /// Auth API EndPoints
  static String get loginEndPoint => getBaseUrl('public/api-mobile-login');

  static String get changePasswordEndPoint =>
      getBaseUrl('public/api-change-password');

  /// Common API EndPoints

  static String get leavesHistoryEndPoint =>
      getBaseUrl('public/api-leave-history');

  static String get holidayHistoryEndPoint =>
      getBaseUrl('public/api-holiday-history');

  static String get presentHistoryEndPoint =>
      getBaseUrl('public/api-present-history');

  static String get absentHistoryEndPoint =>
      getBaseUrl('public/api-absent-history');

  static String get announcementEndPoints =>
      getBaseUrl('public/api-announcement');

  static String get dashboardCountEndPoints =>
      getBaseUrl('public/api-dashboard-report');

  static String get appVersionEndPoints =>
      getBaseUrl('public/api-version-check');

  static String get appMenuEndPoints =>
      getBaseUrl('public/api-menu-permission');

  static String get employeeUserListEndPoint =>
      getBaseUrl('public/api-userlist');

  static String get createAppreciationEndPoints =>
      getBaseUrl('public/api-create-appreciation');

  static String get payrollListEndPoints =>
      getBaseUrl('public/api-get-payroll-list');

  static String get payrollDocumentEndPoints =>
      getBaseUrl('public/api-get-payslip');

  static String get renewalTrackingEndPoints =>
      getBaseUrl('public/api-renewaltracking-data');

  /// Attendance API EndPoints
  static String get attendanceStatus =>
      getBaseUrl('public/api-attendance-status');

  static String get workStartLocationEndPoint =>
      getBaseUrl('public/api-start-attendance');

  static String get workEndLocationEndPoint =>
      getBaseUrl('public/api-end-attendance');

  static String get overallAttendanceEndPoint =>
      getBaseUrl('public/api-overall-attendance');

  static String get attendanceReportLogEndPoint =>
      getBaseUrl('public/api-punch-history');

  static String get gprsCheckerEndPoint =>
      getBaseUrl('public/api-get-gps-status');

  /// Food Attendance API EndPoints
  static String get foodAttendanceReportEndPoint =>
      getBaseUrl('public/api-food-update-report');

  static String get updateFoodAttendanceEndPoint =>
      getBaseUrl('public/api-food-update');

  static String get foodAttendanceStatusEndPoint =>
      getBaseUrl('public/api-food-status');

  /// Account API EndPoints
  // static String get profileDetailEndPoint => getBaseUrl('public/api-profile');
  static String get profileDetailEndPoint =>
      getBaseUrl('public/api-profile-data');

  static String get imageUploadEndPoint =>
      getBaseUrl('public/api-image-upload');

  static String get profileUploadEndPoint =>
      getBaseUrl('public/api-profile-upload');

  static String get profileEditEndPoint =>
      getBaseUrl('public/api-profile-edit');

  /// Misspunch API EndPoints
  static String get misspunchRequestSubmitEndPoint =>
      getBaseUrl('public/api-misspunchsave');

  static String get misspunchApprovedEndPoint =>
      getBaseUrl('public/api-misspunchlist');

  static String get misspunchHistoryEndPoint =>
      getBaseUrl('public/api-misspunch-history');

  static String get misspunchUpdateEndPoint =>
      getBaseUrl('public/api-misspunchupdate');

  static String get misspunchCancelEndPoint =>
      getBaseUrl('public/api-cancel-misspunch');

  static String get forwardEndPoint => getBaseUrl('public/api-leave-forward');

  static String get requestEndPoint => getBaseUrl('public/api-misspunch');

  /// Permission API EndPoints
  static String get permissionApproveEndPoint =>
      getBaseUrl('public/api-odplist');

  static String get permissionHistoryEndPoint =>
      getBaseUrl('public/api-odp-history');

  static String get permissionSubmitEndPoint =>
      getBaseUrl('public/api-permission-request');

  static String get permissionUpdateEndPoint =>
      getBaseUrl('public/api-odpupdate');

  static String get permissionCancelEndPoint =>
      getBaseUrl('public/api-odp-cancel');

  static String get permissionRequestEndPoint =>
      getBaseUrl('public/api-requestbo');

  static String get odBalanceEndPoint => getBaseUrl('public/api-odpbalance');

  static String get shiftTimeEndPoint => getBaseUrl('public/api-shifttime');

  /// Leave API EndPoints
  static String get leaveTypeEndPoint => getBaseUrl('public/api-leave-type');

  static String get leaveModeEndPoint => getBaseUrl('public/api-leave-mode');

  static String get leaveBalanceEndPoint =>
      getBaseUrl('public/api-balanceleave');

  static String get leaveBalanceCalculateEndPoint =>
      getBaseUrl('public/api-leave-balance-calculate');

  static String get leaveForwardEndPoint =>
      getBaseUrl('public/getleaveapprover');

  static String get leaveRequestEndPoint =>
      getBaseUrl('public/api-leave-request');

  static String get leaveCancelEndPoint =>
      getBaseUrl('public/api-cancel-leave');

  static String get leaveUpdateEndPoint =>
      getBaseUrl('public/api-leavedataupdate');

  static String get leaveUserHistoryEndPoint =>
      getBaseUrl('public/api-userleave-history');

  static String get leaveApprovedEndPoint => getBaseUrl('public/api-leavelist');

  static String get leaveApprovedHistoryEndPoint =>
      getBaseUrl('public/api-leave-approval-list');

  /// Sfa API EndPoints
  static String get ticketDropdownListEndPoint =>
      getBaseUrl('public/api-compdetails-data');

  static String get industryBasedVerticalDropdownEndPoint =>
      getBaseUrl('public/api-industry-based-vertical');

  static String get verticalBasedSubVerticalDropdownEndPoint =>
      getBaseUrl('public/api-vertical-based-subvertical');

  static String get databaseDataEndPoint =>
      getBaseUrl('public/api-database-data');

  static String get uploadDatabaseCameraEndPoint =>
      getBaseUrl('public/api-minimal');

  static String get generateTicketEndPoint =>
      getBaseUrl('public/api-database-save');

  // Common
  static String get competencyLevelEndPoint =>
      getBaseUrl('public/api-competency-level');

  static String get educationLevelEndPoint =>
      getBaseUrl('public/api-education-level');

  static String get certificateLevelEndPoint =>
      getBaseUrl('public/api-certificate-data');

  static String get countryEndPoint => getBaseUrl('public/api-country-data');

  static String get stateEndPoint => getBaseUrl('public/api-state-data');

  static String get cityEndPoint => getBaseUrl('public/api-city-data');

  static String get religionEndPoint => getBaseUrl('public/api-religion-data');

  static String get motherTongueEndPoint =>
      getBaseUrl('public/api-mothertongue-data');

  static String get nationalityEndPoint =>
      getBaseUrl('public/api-nationality-data');

  static String get bloodGroupEndPoint =>
      getBaseUrl('public/api-bloodgroup-data');

  static String get skillInsertEndPoint => getBaseUrl('public/api-skills-save');

  static String get skillUpdateEndPoint =>
      getBaseUrl('public/api-skills-update');

  static String get experienceSaveEndPoint =>
      getBaseUrl('public/api-experience-save');

  static String get educationSaveEndPoint =>
      getBaseUrl('public/api-asset-create');

  // static String get educationSaveEndPoint => getBaseUrl('public/api-education-save');
  static String get contactSaveEndPoint =>
      getBaseUrl('public/api-contact-save');

  static String get personalSaveEndPoint =>
      getBaseUrl('public/api-personal-save');

  static String get trainingAndCertificationSaveEndPoint =>
      getBaseUrl('public/api-trainingandcertification-save');

  static String get visaAndImmigrationSaveEndPoint =>
      getBaseUrl('public/api-visaandimmigration-save');

  /// Expense API EndPoints
  static String get expensesTypeEndPoint =>
      getBaseUrl('public/api-expenseslist-data');

  static String get expensesStatusBasedDataEndPoint =>
      getBaseUrl('public/api-expense-status');

  static String get expensesSavePoint => getBaseUrl('public/api-expense-save');

  /// Task API EndPoints

  static String get taskPlannerCommonEndPoint =>
      getBaseUrl('public/api-taskplanner-datebaseddata');

  static String get taskPlannerReportEndPoint =>
      getBaseUrl('public/api-taskplanner-employeebasedstatus');

  static String get taskPlannerTaskStatusEndPoint =>
      getBaseUrl('public/api-taskplanner-taskstatus');

  static String get employeeListEndPoint =>
      getBaseUrl('public/api-taskplanner-employeelist');

  static String get projectListEndPoint =>
      getBaseUrl('public/api-taskplanner-projectlist');

  static String get teamListEndPoint =>
      getBaseUrl('public/api-taskplanner-tllisttaksplanner');

  static String get projectTaskDropdownEndPoint =>
      getBaseUrl('public/api-project-task-dropdown');

  static String get supportTaskSaveEndPoint =>
      getBaseUrl('public/api-taskplanner-supporttasksave');

  static String get taskInitiatedUpdateEndPoint =>
      getBaseUrl('public/api-taskplanner-taskinitiated');

  static String get taskPendingUpdateEndPoint =>
      getBaseUrl('public/api-taskplanner-taskpending');

  static String get taskLeadsEndPoint =>
      getBaseUrl('public/api-taskplanner-taskleads');

  // static String get taskInProgressUpdateEndPoint =>
  //     getBaseUrl('public/api-taskplanner-taskinprogress');
  static String get taskInProgressUpdateEndPoint =>
      getBaseUrl('public/api-taskplanner-taskinprogresstimer');

  static String get taskTestingL1UpdateEndPoint =>
      getBaseUrl('public/api-taskplanner-taskinprogresstimer');

  // static String get taskTestingL1UpdateEndPoint =>
  //     getBaseUrl('public/api-taskplanner-tasktestingl1');
  static String get taskTestingL2UpdateEndPoint =>
      getBaseUrl('public/api-taskplanner-tasktestingl2');

  // Chat
  static String get chatContactEndPoint =>
      getBaseUrl('public/api-chat-contact');

  static String get messageContentEndPoint =>
      getBaseUrl('public/api-get-message');

  static String get saveMessageEndPoint =>
      getBaseUrl('public/api-save-message');

  /// Project Task API EndPoints
  static String get filePathEndPoint => getBaseUrl('public/taskimages');

  static String get fetchProjectTaskEndPoint =>
      getBaseUrl('public/api-task-data');

  static String get projectTaskDeptLeadEndPoint =>
      getBaseUrl('public/api-taskdeptlead');

  static String get projectTaskUpdateEndPoint =>
      getBaseUrl('public/api-task-update');

  static String get projectTaskSaveEndPoint =>
      getBaseUrl('public/api-task-save');
}
