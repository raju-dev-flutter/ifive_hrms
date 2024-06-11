import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class ContactUseCase extends UseCaseWithParams<void, ContactParams> {
  const ContactUseCase(this._repository);

  final AccountRepository _repository;

  @override
  ResultVoid call(ContactParams params) async {
    return _repository.contactSave(params.body);
  }
}

class ContactParams extends Equatable {
  final DataMap body;

  const ContactParams({required this.body});

  @override
  List<Object?> get props => [body];
}
