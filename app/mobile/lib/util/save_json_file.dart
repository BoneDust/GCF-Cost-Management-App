import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonFileUtil{
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _getLocalFile(String userName, String fileName) async {
    final path = await _localPath;
    var pathString = userName == null ? '$path/$fileName' : '$path/$userName/$fileName';
    return File(pathString);
  }

 static Future<File> writeJsonText(String text,String userName, String fileName) async {

   if (userName != null && userName.isNotEmpty){
     final path = await _localPath;
     await Directory('$path/$userName').create(recursive: true);
   }

   final file = await _getLocalFile(userName, fileName);
    return file.writeAsString('$text');
  }

  static void removeFile({String userName, String fileName}) async {
    final path = await _localPath;

    if (fileName != null && fileName.isNotEmpty){
        Directory('$path/$fileName').deleteSync(recursive: true);
    }
  }

  static Future<String> readFromFile(String userName, String fileName) async {
    try {
      final file = await _getLocalFile(userName, fileName);

      return await file.readAsString();

    } catch (e) {
      print(e);
      return "";
    }
  }

  static Future deleteFolder({String username}) async {
    final path = await _localPath;

    Directory('$path').delete(recursive: true);

  }
}