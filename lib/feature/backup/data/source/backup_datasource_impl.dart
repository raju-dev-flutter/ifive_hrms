import 'package:http/http.dart' as http;

import '../../backup.dart';

class BackupDataSourceImpl implements BackupDataSource {
  const BackupDataSourceImpl(this._client);

  final http.Client _client;
}
