import '../../payroll.dart';

abstract class PayrollDataSource {
  Future<PaySlipResponseModel> payslip(String fromDate, String toDate);

  Future<PaySlipModel> payslipDocument(String id);
}
