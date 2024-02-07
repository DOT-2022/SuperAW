import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  File? image;
  File? cameraImage;
  File? video;
  File? cameraVideo;
  File? document;
  BuildContext? context;

  bool isImage = true;
  bool isDoc = false;

  // This function will helps you to pick and Image from Gallery
  Future<XFile?> getImageFromGallery() async {
    XFile? image;
    image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    return image;
  }

  // This function will helps you to pick and Image from Camera
  Future<XFile?> getImageFromCamera() async {
    XFile? image;
    image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 70);
    return image;
  }
}