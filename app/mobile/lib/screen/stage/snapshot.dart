import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';

class SnapShotCard extends StatelessWidget {
  final Stage stage;

  const SnapShotCard({Key key, @required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/foreman/stages");
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text("Snap Shot"),
              )),
          _SnapShotCardDetail(stage: stage,),
          Container(

            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: 160,
            height: 50,
            child: RaisedButton(
              child: Text("Set Stage Finished"),
              onPressed: () {},

            ),
          ),
          Text("*Both picture have to present in order to finish the project"),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
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
      children: <Widget>[_getImage(stage.beforePicture, "before"), _getImage(stage.afterPicture, "after")],
    );
  }

  Widget _getImage(String pictureUrl, String title) {
    Widget pictureWidget;
    if (pictureUrl == null || pictureUrl.isEmpty)
      pictureWidget = Center(child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){}),);
    else
      pictureWidget = Image(
        image: AssetImage("assets/images.jpeg"),
        fit: BoxFit.cover,
      );
    return StageImage(title: title, pictureWidget: pictureWidget,);
  }
}

class StageImage extends StatelessWidget {
  final String title;
  final Widget pictureWidget;

  const StageImage({Key key,@required this.title, @required this.pictureWidget}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title),
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
          child: pictureWidget,
        )
      ],
    );
  }
}
