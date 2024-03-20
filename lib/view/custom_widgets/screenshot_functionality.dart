import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:screenshot/screenshot.dart';

class TakeScreenShot{
  static ScreenshotController controller = ScreenshotController();
  static Future<String?> captureScreen() async {
    try {
      Uint8List? imageBytes = await controller.capture();
      if (imageBytes != null) {
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/screenshot.png';
        File imageFile = File(imagePath);
        await imageFile.writeAsBytes(imageBytes);
        return imagePath;
      }
    } catch (e) {
    }
    return null;
  }




  static cropper(String imagePath) async {
    await ImageCropper().cropImage(
      sourcePath: imagePath,
      cropStyle: CropStyle.rectangle,
      compressQuality: 100,
      compressFormat: ImageCompressFormat.png,
      // aspectRatio: const CropAspectRatio(ratioX: 20, ratioY: 79),
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    ).then((value) async {
      if(value!=null){
        await ImageGallerySaver.saveFile(value.path);

        // Share the cropped image
        final bytes = await value.readAsBytes();
        await Share.file(
          'Share via',
          'image.jpg',
          bytes.buffer.asUint8List(),
          'image/jpg',
        );
      }else{
      }

    });
  }
}