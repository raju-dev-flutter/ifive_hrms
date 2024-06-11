import '../../../feature.dart';

class AssetsManagementRepositoryImpl implements AssetsManagementRepository {
  const AssetsManagementRepositoryImpl(this._datasource);

  final AssetsManagementDataSource _datasource;
}
