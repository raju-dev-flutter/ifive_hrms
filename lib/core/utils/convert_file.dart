import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class ConvertUrl {
  Future<File> toFile(String uri) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    http.Response response = await http.get(Uri.parse(uri));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  void fileDownload(String uri, String fileName) async {
    HttpClient httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse('$uri/$fileName'));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        String dir = (await getApplicationDocumentsDirectory()).path;
        String filePath = '$dir/$fileName';
        File file = File(filePath);
        await file.writeAsBytes(bytes);
        Logger().i(filePath);
      } else {
        Logger().e('Error code: ${response.statusCode}');
      }
    } catch (ex) {
      Logger().e('Can not fetch url');
    }
  }
}
