import 'dart:io';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    log("picking image");
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
