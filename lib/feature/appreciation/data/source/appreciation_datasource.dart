import '../../../../core/core.dart';
import '../../appreciation.dart';

abstract class AppreciationDataSource {
  Future<void> appreciationRequest(DataMap body);

  Future<EmployeeUserModel> employeeUserList();
}
