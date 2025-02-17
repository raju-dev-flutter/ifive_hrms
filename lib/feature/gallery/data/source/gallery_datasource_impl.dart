import 'package:http/http.dart' as http;

import '../../gallery.dart';

class GalleryDataSourceImpl implements GalleryDataSource {
  const GalleryDataSourceImpl(this._client);

  final http.Client _client;
}
