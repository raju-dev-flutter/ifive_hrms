import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../task.dart';

class TestL2TaskTaskUpdateUseCase
    extends UseCaseWithParams<void, TestL2TaskParams> {
  const TestL2TaskTaskUpdateUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<void> call(TestL2TaskParams params) async {
    return _repository.testL2TaskUpdate(params.body);
  }
}

class TestL2TaskParams extends Equatable {
  final DataMap body;

  const TestL2TaskParams(this.body);

  @override
  List<Object?> get props => [body];
}
