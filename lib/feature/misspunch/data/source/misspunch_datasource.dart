import '../../../../core/core.dart';
import '../../misspunch.dart';

abstract class MisspunchDataSource {
  Future<MisspunchListModel> getMisspunchRequestList();

  Future<MisspunchForwardListModel> getMisspunchForwardToList();

  Future<MisspunchMessageModel> misspunchRequestSave(DataMap body);

  Future<MisspunchHistoryModel> getMisspunchHistory(
      String fromDate, String toDate);

  Future<void> misspunchCancel(DataMap body);

  Future<void> misspunchUpdate(DataMap body);

  Future<MisspunchApprovedModel> misspunchApproved(
      String fromDate, String toDate);
}
