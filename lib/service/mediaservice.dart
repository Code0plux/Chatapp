import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Mediaservice {
  final ImagePicker _picker = ImagePicker();
  Mediaservice() {}
  Future<File?> GetImageFromGalary() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
