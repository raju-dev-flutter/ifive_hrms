import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class OtherServiceRepositoryImpl implements OtherServiceRepository {
  const OtherServiceRepositoryImpl(this._datasource);

  final OtherServiceDataSource _datasource;

  @override
  ResultFuture<RenewalTrackerModel> renewalTracker(String status) async {
    try {
      final permissionResponse = await _datasource.renewalTracker(status);
      return Right(permissionResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
