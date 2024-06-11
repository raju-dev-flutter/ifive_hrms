import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class SfaRepository {
  ResultFuture<TicketDropdownModel> getTicketDropdown();

  ResultFuture<TicketDropdownModel> industryBasedVerticalDropdown(int id);

  ResultFuture<TicketDropdownModel> verticalBasedSubVerticalDropdown(int id);

  ResultVoid uploadGenerateTicket(DataMap body, String type);

  ResultFuture<DatabaseDataModel> getTicket(
      DataMapString header, int page, int parPage);
}
