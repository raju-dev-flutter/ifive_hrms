import '../../../../core/core.dart';
import '../../appreciation.dart';

abstract class AppreciationRepository {
  ResultVoid appreciationRequest(DataMap body);

  ResultFuture<EmployeeUserModel> employeeUserList();
}
