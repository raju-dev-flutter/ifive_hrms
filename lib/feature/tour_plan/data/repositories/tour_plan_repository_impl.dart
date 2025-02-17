import '../../../feature.dart';

class TourPlanRepositoryImpl implements TourPlanRepository {
  const TourPlanRepositoryImpl(this._datasource);

  final TourPlanDataSource _datasource;
}
