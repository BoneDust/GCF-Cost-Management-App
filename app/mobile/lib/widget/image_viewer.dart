import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final File image;
  final ImageProvider imageProvider;
  const ImageViewer({Key key, this.image, this.imageProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ReceiptImageViewer(image: image, imageProvider: imageProvider,),
    );
  }
}

class _ReceiptImageViewer extends StatelessWidget {
  final File image;
  final ImageProvider imageProvider;

  const _ReceiptImageViewer({Key key, this.image, this.imageProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: imageProvider == null ? FileImage(image) : imageProvider,
    );
  }
}
