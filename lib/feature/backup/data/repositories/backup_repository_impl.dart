import '../../backup.dart';

class BackupRepositoryImpl implements BackupRepository {
  const BackupRepositoryImpl(this._datasource);

  final BackupDataSource _datasource;
}
