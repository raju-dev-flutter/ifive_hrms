import 'package:ifive_hrms/feature/appreciation/appreciation.dart';

import '../../../../core/core.dart';

class EmployeeUserListUserCase extends UseCaseWithoutParams<EmployeeUserModel> {
  const EmployeeUserListUserCase(this._repository);

  final AppreciationRepository _repository;

  @override
  ResultFuture<EmployeeUserModel> call() {
    return _repository.employeeUserList();
  }
}
