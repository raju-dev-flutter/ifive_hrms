import 'package:http/http.dart' as http;

import '../../assets_management.dart';

class AssetsManagementDataSourceImpl implements AssetsManagementDataSource {
  const AssetsManagementDataSourceImpl(this._client);

  final http.Client _client;
}
