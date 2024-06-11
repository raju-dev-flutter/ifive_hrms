import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../task.dart';

class InProgressTaskUpdateUseCase
    extends UseCaseWithParams<void, InProgressTaskParams> {
  const InProgressTaskUpdateUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<void> call(InProgressTaskParams params) async {
    return _repository.inProgressTaskUpdate(params.body);
  }
}

class InProgressTaskParams extends Equatable {
  final DataMap body;

  const InProgressTaskParams(this.body);

  @override
  List<Object?> get props => [body];
}
