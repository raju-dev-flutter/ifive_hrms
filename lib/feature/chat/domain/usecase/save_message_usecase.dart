import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../chat.dart';

class SaveMessageUseCase extends UseCaseWithParams<void, SaveMessageParams> {
  const SaveMessageUseCase(this._repository);

  final ChatRepository _repository;

  @override
  ResultVoid call(SaveMessageParams params) async {
    return _repository.saveMessage(params.body);
  }
}

class SaveMessageParams extends Equatable {
  final DataMap body;

  const SaveMessageParams({required this.body});

  @override
  List<Object> get props => [body];
}
