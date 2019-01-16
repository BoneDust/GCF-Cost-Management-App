import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SnapShotCard extends StatelessWidget {
  final Stage stage;

  const SnapShotCard({Key key, @required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Text(
            "snapshot",
            style: TextStyle(color: themeData.primaryTextTheme.display1.color, fontSize: 30),
          ),
        ),
        _SnapShotCardDetail(stage: stage,)
      ],
    );
  }
}
class _SnapShotCardDetail extends StatefulWidget {
  final Stage stage;

  const _SnapShotCardDetail({Key key, this.stage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SnapShotCardDetailState();
  }
  
}
class _SnapShotCardDetailState extends State<_SnapShotCardDetail> {
  File _beforeImage;
  File _afterImage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 12,
      children: <Widget>[
        _getImage(widget.stage.beforePicture, "before", context, true),
        _getImage(widget.stage.afterPicture, "after", context, false)
      ],
    );
  }

  Widget _getImage(String pictureUrl, String title, BuildContext context, bool isBefore) {
    ThemeData themeData = Theme.of(context);

    Widget pictureWidget;
    if (pictureUrl == null || pictureUrl.trim().isEmpty)
      pictureWidget = Center(
        child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {getImage(isBefore);}),
      );
    else if (isBefore && _beforeImage != null)
      pictureWidget = Image.file(_beforeImage);
    else if (_afterImage != null)
      pictureWidget = Image.file(_afterImage);
    else
      pictureWidget = CachedNetworkImage(
        imageUrl: pictureUrl,
        placeholder:  Text("loading picture...", style: TextStyle(color: themeData.primaryTextTheme.display1.color)),
        errorWidget:  Icon(Icons.error),
        fit: BoxFit.cover,
      );
    return StageImage(
      title: title,
      pictureWidget: pictureWidget,
    );
    
  }

  Future getImage(bool isBefore) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 1600, maxHeight: 1200);
    setState(() {
      if (isBefore){
        _beforeImage = image;
      }
      else
        _afterImage = image;

    });
    print(_beforeImage.statSync());
  }
  
}
class StageImage extends StatefulWidget {
  final String title;
  final Widget pictureWidget;

  StageImage(
      {@required this.title, @required this.pictureWidget});
  
  @override
  State<StatefulWidget> createState() {
    return _StageImage();
  }
}
class _StageImage extends State<StageImage> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.title),
        Container(
          height: 150,
          width: 150,
          child: widget.pictureWidget,
        )
      ],
    );
  }


}
