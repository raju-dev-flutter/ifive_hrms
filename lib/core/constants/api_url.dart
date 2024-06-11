class ApiUrl {
  static const String baseUrl = "https://i5erp.in/i5smarthr/";

  /// Auth API EndPoints
  static var loginEndPoint = '${baseUrl}public/api-mobile-login';

  static var changePasswordEndPoint = '${baseUrl}public/api-change-password';

  /// Common API EndPoints

  static var leavesHistoryEndPoint = '${baseUrl}public/api-leave-history';
  static var holidayHistoryEndPoint = '${baseUrl}public/api-holiday-history';
  static var presentHistoryEndPoint = '${baseUrl}public/api-present-history';
  static var absentHistoryEndPoint = '${baseUrl}public/api-absent-history';

  static var announcementEndPoints = '${baseUrl}public/api-announcement';

  static var dashboardCountEndPoints = '${baseUrl}public/api-dashboard-report';

  static var appVersionEndPoints = '${baseUrl}public/api-version-check';

  static var appMenuEndPoints = '${baseUrl}public/api-menu-permission';

  static var employeeUserListEndPoint = '${baseUrl}public/api-userlist';

  static var createAppreciationEndPoints =
      '${baseUrl}public/api-create-appreciation';

  static var payrollListEndPoints = '${baseUrl}public/api-get-payroll-list';
  static var payrollDocumentEndPoints = '${baseUrl}public/api-get-payslip';

  static var renewalTrackingEndPoints =
      '${baseUrl}public/api-renewaltracking-data';

  /// Attendance API EndPoints
  static var attendanceStatus = '${baseUrl}public/api-attendance-status';
  static var workStartLocationEndPoint =
      '${baseUrl}public/api-start-attendance';
  static var workEndLocationEndPoint = '${baseUrl}public/api-end-attendance';

  static var overallAttendanceEndPoint =
      '${baseUrl}public/api-overall-attendance';
  static var attendanceReportLogEndPoint = '${baseUrl}public/api-punch-history';

  static var gprsCheckerEndPoint = '${baseUrl}public/api-get-gps-status';

  /// Food Attendance API EndPoints
  static var foodAttendanceReportEndPoint =
      '${baseUrl}public/api-food-update-report';
  static var updateFoodAttendanceEndPoint = '${baseUrl}public/api-food-update';
  static var foodAttendanceStatusEndPoint = '${baseUrl}public/api-food-status';

  /// Account API EndPoints
  // static var profileDetailEndPoint = '${baseUrl}public/api-profile';
  static var profileDetailEndPoint = '${baseUrl}public/api-profile-data';

  static var imageUploadEndPoint = '${baseUrl}public/api-image-upload';

  static var profileUploadEndPoint = '${baseUrl}public/api-profile-upload';
  static var profileEditEndPoint = '${baseUrl}public/api-profile-edit';

  /// Misspunch API EndPoints
  static var misspunchRequestSubmitEndPoint =
      '${baseUrl}public/api-misspunchsave';

  static var misspunchApprovedEndPoint = '${baseUrl}public/api-misspunchlist';

  static var misspunchHistoryEndPoint =
      '${baseUrl}public/api-misspunch-history';

  static var misspunchUpdateEndPoint = '${baseUrl}public/api-misspunchupdate';

  static var misspunchCancelEndPoint = '${baseUrl}public/api-cancel-misspunch';

  static var forwardEndPoint = '${baseUrl}public/api-leave-forward';
  static var requestEndPoint = '${baseUrl}public/api-misspunch';

  /// Permission API EndPoints
  static var permissionApproveEndPoint = '${baseUrl}public/api-odplist';
  static var permissionHistoryEndPoint = '${baseUrl}public/api-odp-history';

  static var permissionSubmitEndPoint =
      '${baseUrl}public/api-permission-request';

  static var permissionUpdateEndPoint = '${baseUrl}public/api-odpupdate';
  static var permissionCancelEndPoint = '${baseUrl}public/api-odp-cancel';

  static var permissionRequestEndPoint = '${baseUrl}public/api-requestbo';
  static var odBalanceEndPoint = '${baseUrl}public/api-odpbalance';
  static var shiftTimeEndPoint = '${baseUrl}public/api-shifttime';

  /// Leave API EndPoints
  static var leaveTypeEndPoint = '${baseUrl}public/api-leave-type';
  static var leaveModeEndPoint = '${baseUrl}public/api-leave-mode';
  static var leaveBalanceEndPoint = '${baseUrl}public/api-balanceleave';
  static var leaveBalanceCalculateEndPoint =
      '${baseUrl}public/api-leave-balance-calculate';
  static var leaveForwardEndPoint = '${baseUrl}public/getleaveapprover';

  static var leaveRequestEndPoint = '${baseUrl}public/api-leave-request';
  static var leaveCancelEndPoint = '${baseUrl}public/api-cancel-leave';
  static var leaveUpdateEndPoint = '${baseUrl}public/api-leavedataupdate';

  static var leaveUserHistoryEndPoint =
      '${baseUrl}public/api-userleave-history';

  static var leaveApprovedEndPoint = '${baseUrl}public/api-leavelist';
  static var leaveApprovedHistoryEndPoint =
      '${baseUrl}public/api-leave-approval-list';

  /// Sfa API EndPoints
  static var ticketDropdownListEndPoint =
      '${baseUrl}public/api-compdetails-data';

  static var industryBasedVerticalDropdownEndPoint =
      '${baseUrl}public/api-industry-based-vertical';

  static var verticalBasedSubVerticalDropdownEndPoint =
      '${baseUrl}public/api-vertical-based-subvertical';

  static var databaseDataEndPoint = '${baseUrl}public/api-database-data';

  static var generateTicketEndPoint = '${baseUrl}public/api-database-save';

  // Common
  static var competencyLevelEndPoint = '${baseUrl}public/api-competency-level';
  static var educationLevelEndPoint = '${baseUrl}public/api-education-level';
  static var certificateLevelEndPoint = '${baseUrl}public/api-certificate-data';
  static var countryEndPoint = '${baseUrl}public/api-country-data';
  static var stateEndPoint = '${baseUrl}public/api-state-data';
  static var cityEndPoint = '${baseUrl}public/api-city-data';
  static var religionEndPoint = '${baseUrl}public/api-religion-data';
  static var motherTongueEndPoint = '${baseUrl}public/api-mothertongue-data';
  static var nationalityEndPoint = '${baseUrl}public/api-nationality-data';
  static var bloodGroupEndPoint = '${baseUrl}public/api-bloodgroup-data';

  static var skillInsertEndPoint = '${baseUrl}public/api-skills-save';
  static var skillUpdateEndPoint = '${baseUrl}public/api-skills-update';

  static var experienceSaveEndPoint = '${baseUrl}public/api-experience-save';
  static var educationSaveEndPoint = '${baseUrl}public/api-asset-create';

  // static var educationSaveEndPoint = '${baseUrl}public/api-education-save';
  static var contactSaveEndPoint = '${baseUrl}public/api-contact-save';

  static var personalSaveEndPoint = '${baseUrl}public/api-personal-save';
  static var trainingAndCertificationSaveEndPoint =
      '${baseUrl}public/api-trainingandcertification-save';
  static var visaAndImmigrationSaveEndPoint =
      '${baseUrl}public/api-visaandimmigration-save';

  /// Expense API EndPoints
  static var expensesTypeEndPoint = '${baseUrl}public/api-expenseslist-data';

  static var expensesStatusBasedDataEndPoint =
      '${baseUrl}public/api-expense-status';

  static var expensesSavePoint = '${baseUrl}public/api-expense-save';

  /// Task API EndPoints

  static var taskPlannerCommonEndPoint =
      '${baseUrl}public/api-taskplanner-datebaseddata';
  static var taskPlannerReportEndPoint =
      '${baseUrl}public/api-taskplanner-employeebasedstatus';
  static var taskPlannerTaskStatusEndPoint =
      '${baseUrl}public/api-taskplanner-taskstatus';
  static var employeeListEndPoint =
      '${baseUrl}public/api-taskplanner-employeelist';
  static var projectListEndPoint =
      '${baseUrl}public/api-taskplanner-projectlist';
  static var teamListEndPoint =
      '${baseUrl}public/api-taskplanner-tllisttaksplanner';

  static var supportTaskSaveEndPoint =
      '${baseUrl}public/api-taskplanner-supporttasksave';
  static var taskInitiatedUpdateEndPoint =
      '${baseUrl}public/api-taskplanner-taskinitiated';
  static var taskPendingUpdateEndPoint =
      '${baseUrl}public/api-taskplanner-taskpending';

  // static var taskInProgressUpdateEndPoint =
  //     '${baseUrl}public/api-taskplanner-taskinprogress';
  static var taskInProgressUpdateEndPoint =
      '${baseUrl}public/api-taskplanner-taskinprogresstimer';
  static var taskTestingL1UpdateEndPoint =
      '${baseUrl}public/api-taskplanner-taskinprogresstimer';

  // static var taskTestingL1UpdateEndPoint =
  //     '${baseUrl}public/api-taskplanner-tasktestingl1';
  static var taskTestingL2UpdateEndPoint =
      '${baseUrl}public/api-taskplanner-tasktestingl2';
}
