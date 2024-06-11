import '../../../../core/core.dart';
import '../../database.dart';

abstract class SfaDataSource {
  Future<TicketDropdownModel> getTicketDropdown();

  Future<TicketDropdownModel> industryBasedVerticalDropdown(int id);

  Future<TicketDropdownModel> verticalBasedSubVerticalDropdown(int id);

  Future<DatabaseDataModel> getTicket(
      DataMapString header, int page, int parPage);

  Future<void> uploadGenerateTicket(DataMap body, String type);
}
