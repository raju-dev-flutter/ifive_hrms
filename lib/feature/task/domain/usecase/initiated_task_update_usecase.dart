import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../task.dart';

class InitiatedTaskUpdateUseCase
    extends UseCaseWithParams<void, InitiatedTaskParams> {
  const InitiatedTaskUpdateUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<void> call(InitiatedTaskParams params) async {
    return _repository.initiatedTaskUpdate(params.body);
  }
}

class InitiatedTaskParams extends Equatable {
  final DataMap body;

  const InitiatedTaskParams(this.body);

  @override
  List<Object?> get props => [body];
}
