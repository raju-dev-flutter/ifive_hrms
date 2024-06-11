import 'dart:io';
import 'package:image/image.dart' as ui;

import 'package:camera/camera.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ImageWatermark {
  static Future<XFile?> convert(XFile image) async {
    try {
      ui.Image? originalImage =
          ui.decodeImage(File(image.path).readAsBytesSync());

      String waterMarkText =
          DateFormat('yyyy-MM-dd HH:mm ss').format(DateTime.now());

      ui.drawString(originalImage!, waterMarkText,
          font: ui.arial14,
          x: 10,
          y: 10,
          color: ui.ColorRgb8.from(ColorUint8.rgb(255, 0, 0)));

      var tempDir = await getTemporaryDirectory();
      File('${tempDir.path}/$waterMarkText.png')
          .writeAsBytesSync(ui.encodePng(originalImage));
      // File watermarkedImage = File('${tempDir.path}/$waterMarkText.png');

      return XFile('${tempDir.path}/$waterMarkText.png');
    } catch (e) {
      return null;
    }
  }
}
