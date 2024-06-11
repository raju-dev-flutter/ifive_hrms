import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class ODPermissionDataSource {
  Future<PermissionResponseModel> permissionHistory();

  Future<PermissionHistoryModel> permissionApproval();

  Future<void> permissionRequest(DataMap body);

  Future<PermissionRequestModel> requestTo();

  Future<ODBalanceModel> odBalance(int type);

  Future<ShiftTimeResponseModel> shiftTime();

  Future<void> permissionSubmit(DataMap body);

  Future<void> permissionUpdate(DataMap body);

  Future<void> permissionCancel(DataMap body);
}
