import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class ODPermissionRepository {
  ResultFuture<PermissionResponseModel> permissionHistory();

  ResultFuture<PermissionHistoryModel> permissionApproval();

  ResultVoid permissionRequest(DataMap body);

  ResultFuture<PermissionRequestModel> requestTo();

  ResultFuture<ODBalanceModel> odBalance(int type);

  ResultFuture<ShiftTimeResponseModel> shiftTime();

  ResultVoid permissionSubmit(DataMap body);

  ResultVoid permissionUpdate(DataMap body);

  ResultVoid permissionCancel(DataMap body);
}
