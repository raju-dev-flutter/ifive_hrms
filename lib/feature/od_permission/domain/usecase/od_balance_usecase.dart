import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../od_permission.dart';

class ODBalanceUseCase
    extends UseCaseWithParams<ODBalanceModel, ODBalanceParams> {
  const ODBalanceUseCase(this._repository);

  final ODPermissionRepository _repository;

  @override
  ResultFuture<ODBalanceModel> call(ODBalanceParams params) async {
    return _repository.odBalance(params.type);
  }
}

class ODBalanceParams extends Equatable {
  final int type;

  const ODBalanceParams({required this.type});

  const ODBalanceParams.empty() : this(type: 0);

  @override
  List<Object?> get props => [type];
}
