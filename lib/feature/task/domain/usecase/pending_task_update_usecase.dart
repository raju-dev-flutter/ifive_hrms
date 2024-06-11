import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../task.dart';

class PendingTaskUpdateUseCase
    extends UseCaseWithParams<void, PendingTaskParams> {
  const PendingTaskUpdateUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<void> call(PendingTaskParams params) async {
    return _repository.pendingTaskUpdate(params.body);
  }
}

class PendingTaskParams extends Equatable {
  final DataMap body;

  const PendingTaskParams(this.body);

  @override
  List<Object?> get props => [body];
}
