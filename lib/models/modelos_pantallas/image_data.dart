import 'dart:typed_data';

class ImageData {
  ImageData({
    required this.height,
    required this.width,
    required this.size,
    required this.image,
  });

  final int height;
  final int width;
  final int size;
  final Uint8List image;
}
