import '../../../feature.dart';

abstract class OtherServiceDataSource {
  Future<RenewalTrackerModel> renewalTracker(String status);
}
