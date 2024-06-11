import '../../../../core/core.dart';
import '../../../feature.dart';

class EmployeeListUseCase extends UseCaseWithoutParams<EmployeeModel> {
  const EmployeeListUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<EmployeeModel> call() async {
    return await _repository.employeeList();
  }
}
