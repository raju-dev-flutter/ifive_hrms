import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../task.dart';

class SupportTaskUseCase extends UseCaseWithParams<void, SupportTaskParams> {
  const SupportTaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<void> call(SupportTaskParams params) async {
    return _repository.supportTask(params.body);
  }
}

class SupportTaskParams extends Equatable {
  final DataMap body;

  const SupportTaskParams(this.body);

  @override
  List<Object?> get props => [body];
}
