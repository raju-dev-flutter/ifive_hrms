import '../../../feature.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  const GalleryRepositoryImpl(this._datasource);

  final GalleryDataSource _datasource;
}
