import 'package:http/http.dart' as http;

import '../../tour_plan.dart';

class TourPlanDataSourceImpl implements TourPlanDataSource {
  const TourPlanDataSourceImpl(this._client);

  final http.Client _client;
}
