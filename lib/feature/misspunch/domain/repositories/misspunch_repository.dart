import '../../../../core/core.dart';
import '../../misspunch.dart';

abstract class MisspunchRepository {
  ResultFuture<MisspunchListModel> getMisspunchRequestList();

  ResultFuture<MisspunchForwardListModel> getMisspunchForwardToList();

  ResultFuture<MisspunchMessageModel> misspunchRequestSave(DataMap body);

  ResultFuture<MisspunchHistoryModel> getMisspunchHistory(
      String fromDate, String toDate);

  ResultFuture<MisspunchApprovedModel> misspunchApproved(
      String fromDate, String toDate);

  ResultVoid misspunchCancel(DataMap body);

  ResultVoid misspunchUpdate(DataMap body);
}
