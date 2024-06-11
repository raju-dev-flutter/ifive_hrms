import 'package:ifive_hrms/core/core.dart';

import '../../../feature.dart';

abstract interface class OtherServiceRepository {
  ResultFuture<RenewalTrackerModel> renewalTracker();
}
