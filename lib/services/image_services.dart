import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageServices {
  //--------------------------------------------
  static Future<Uint8List> resizeImage(
    Uint8List imageList,
  ) async {
    int? imageWidth;
    int? imageHeight;

    final decodedImg = await decodeImageFromList(imageList);
    imageWidth = decodedImg.width;
    imageHeight = decodedImg.height;

    if (imageHeight <= 1600) {
      return imageList;
    }

    final newWidth = (imageWidth / (imageHeight + 0.0)) * 1600;

    final result = await FlutterImageCompress.compressWithList(
      imageList,
      minHeight: 1600,
      minWidth: newWidth.toInt(),
      quality: 95,
    );

    final decodedResult = await decodeImageFromList(result);
    final resizeImgHeight = decodedResult.height;
    final resizeImgWidth = decodedResult.width;

    return result;
  }

  //--------------------------------------------
  static Future<File?> pickImage([bool isMultiImage = false]) async {
    // FilePickerResult? images = await FilePicker.platform.pickFiles(
    //   allowMultiple: isMultiImage,
    //   type: FileType.image,
    // );
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    if (!isMultiImage) {
      final path = image.path;
      return File(path);
    }
    return null;
  }

  //--------------------------------------------
  Future<File?> imageToUint8List(File imagee) async {
    // Read the file as bytes
    List<int> bytes = imagee.readAsBytesSync();
    final appDocDir = await getApplicationDocumentsDirectory();

    // Decode the image
    File? file = File(imagee.path);
    String fileName = basename(file.path);
    final destOriginalFilePath = '$appDocDir/$fileName';
    final newImage = await imagee.copy(destOriginalFilePath);

    return newImage;
  }
}
