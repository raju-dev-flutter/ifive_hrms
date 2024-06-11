import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../food.dart';

class UpdateFoodAttendance
    extends UseCaseWithParams<void, UpdateFoodRequestParams> {
  const UpdateFoodAttendance(this._repository);

  final FoodRepository _repository;

  @override
  ResultVoid call(UpdateFoodRequestParams params) async {
    return _repository.updateFoodAttendance(params.status);
  }
}

class UpdateFoodRequestParams extends Equatable {
  final String status;

  const UpdateFoodRequestParams({required this.status});

  const UpdateFoodRequestParams.empty() : this(status: "_empty.status");

  @override
  List<Object?> get props => [status];
}
