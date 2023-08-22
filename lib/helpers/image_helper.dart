import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class ImageHelper {
  Future<String> saveWidgetToImage(GlobalKey<SfCartesianChartState> key, String widgetId) async {
    final ui.Image data = await key.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    final List<int> imageBytes = bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    final String filename = 'mk/$widgetId/statisticImg.png';
    return saveFile(filename, imageBytes);
  }

  Future<String> downloadImage(String url, String filename) async {
      final http.Response response = await http.get(Uri.parse(url));
      return saveFile(filename ,response.bodyBytes);
  }

  Future<String> saveFile(String filename, List<int> bytes) async {
    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;

    File file = File('$path/$filename');

    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    await file.writeAsBytes(bytes, flush: true);

    return file.path;
  }
}