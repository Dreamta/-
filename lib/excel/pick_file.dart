import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

Future<Excel?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls', 'xlsm'],
  );
  if (result != null) {
    PlatformFile file = result.files.first;
    Uint8List list = File(file.path!).readAsBytesSync();
    Excel excel = Excel.decodeBytes(list);
    return excel;
  }
  return null;
}
