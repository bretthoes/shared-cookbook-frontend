import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

/// Helper class for image related operations.
///
class ImageUtils {
  ImageUtils._();

  static Future<File> getCompressedImage(String filepath) async {
    var imageToCompress = File(filepath);
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.path, getUniqueFilename(filepath));

    var compressedFile = await FlutterImageCompress.compressAndGetFile(
      imageToCompress.absolute.path,
      targetPath,
      quality: 75,
    );
    return File(compressedFile!.path);
  }

  static String getUniqueFilename(String filepath) {
    return Uuid().v1().toString() + path.extension(filepath);
  }
}
