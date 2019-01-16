import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final File image;

  const ImageViewer({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ReceiptImageViewer(image: image),
    );
  }
}

class _ReceiptImageViewer extends StatelessWidget {
  final File image;

  const _ReceiptImageViewer({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: FileImage(image),
    );
  }
}
