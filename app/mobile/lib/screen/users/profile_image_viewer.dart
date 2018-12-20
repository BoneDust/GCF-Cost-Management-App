import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfileImageViewer extends StatelessWidget {
  final File image;

  const ProfileImageViewer({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ProfileImageViewer(image: image),
    );
  }
}

class _ProfileImageViewer extends StatelessWidget {
  final File image;

  const _ProfileImageViewer({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PhotoView(
      imageProvider: FileImage(image),
    );
  }
}
