import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DeleteFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _DeleteFileState();

}

class _DeleteFileState extends State<DeleteFile> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

    );
  }
}

Future<void> deleteDatabaseFile() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/database.json');

    if (await file.exists()) {
      await file.delete();
      print('database.json dosyası başarıyla silindi.');
    } else {
      print('database.json dosyası zaten bulunmuyor.');
    }
  } catch (e) {
    print('Dosya silinirken bir hata oluştu: $e');
  }
}

