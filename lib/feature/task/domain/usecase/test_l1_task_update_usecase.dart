import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../task.dart';

class TestL1TaskTaskUpdateUseCase
    extends UseCaseWithParams<void, TestL1TaskParams> {
  const TestL1TaskTaskUpdateUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<void> call(TestL1TaskParams params) async {
    return _repository.testL1TaskUpdate(params.body);
  }
}

class TestL1TaskParams extends Equatable {
  final DataMap body;

  const TestL1TaskParams(this.body);

  @override
  List<Object?> get props => [body];
}
