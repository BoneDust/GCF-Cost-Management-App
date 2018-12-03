import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ReceiptImageViewer extends  StatelessWidget{
  final File image;

  const ReceiptImageViewer({Key key, this.image}) : super(key: key);

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
    // TODO: implement build
    return PhotoView(
      imageProvider: FileImage(image),
    );
  }
}

