import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageService {
  Future<String> compressAndSaveImage(String sourcePath) async {
    final file = File(sourcePath);
    if (!await file.exists()) {
      throw Exception('Image file not found at $sourcePath');
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final targetPath = p.join(docsDir.path, fileName);

    final result = await FlutterImageCompress.compressAndGetFile(
      sourcePath,
      targetPath,
      quality: 70,
      format: CompressFormat.jpeg,
    );

    if (result == null) {
      throw Exception('Failed to compress image');
    }

    return result.path;
  }
}
