import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class PayrollRepository {
  ResultFuture<PaySlipResponseModel> payslip(String fromDate, String toDate);

  ResultFuture<PaySlipModel> payslipDocument(String id);
}
