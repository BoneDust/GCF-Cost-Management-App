import 'package:flutter/material.dart';

class SnapShotCard extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  SnapShotCard() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/foreman/stages");
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text("Snap Shot", style: headerStyle),
              )),
          SnapShotCardDetail(),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: 160,
            height: 50,
            child: RaisedButton(

              color: Colors.lightGreenAccent,
              child: Text("Set Stage Finished"),
              onPressed: () {},
            ),
          ),
          Text("*Both picture have to present in order to finish the project"),
          Padding(padding: EdgeInsets.only(top: 20.0),),

        ],
      ),
    );
  }
}

class SnapShotCardDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 12,
        children: <Widget>[
          StageImage(),
          StageImage()

        ],
      );
  }
}

class StageImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("After"),
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.amber)
          ),
          child: Image(
            image: AssetImage("assets/images.jpeg"),
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

}


