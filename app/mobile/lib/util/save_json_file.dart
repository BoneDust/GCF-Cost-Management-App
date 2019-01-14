import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonFileUtil{
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _getLocalFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

 static Future<File> writeJsonText(String text, String fileName) async {
    final file = await _getLocalFile(fileName);
    return file.writeAsString('$text');
  }

  static Future<String> readFromFile(String fileName) async {
    try {
      final file = await _getLocalFile(fileName);

      // Read the file
      return await file.readAsString();

    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }
}