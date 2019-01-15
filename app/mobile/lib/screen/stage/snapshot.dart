import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';

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

class _SnapShotCardDetail extends StatelessWidget {
  final Stage stage;

  const _SnapShotCardDetail({Key key, @required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 12,
      children: <Widget>[
        _getImage(stage.beforePicture, "before"),
        _getImage(stage.afterPicture, "after")
      ],
    );
  }

  Widget _getImage(String pictureUrl, String title) {
    Widget pictureWidget;
    if (pictureUrl == null || pictureUrl.isEmpty)
      pictureWidget = Center(
        child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {}),
      );
    else
      pictureWidget = Image(
        image: AssetImage("assets/images.jpeg"),
        fit: BoxFit.cover,
      );
    return StageImage(
      title: title,
      pictureWidget: pictureWidget,
    );
  }
}

class StageImage extends StatelessWidget {
  final String title;
  final Widget pictureWidget;

  const StageImage(
      {Key key, @required this.title, @required this.pictureWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title),
        Container(
          height: 150,
          width: 150,
          child: pictureWidget,
        )
      ],
    );
  }
}
