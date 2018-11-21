import 'package:flutter/material.dart';
import 'base_project_card.dart';

class RecentActivityCard extends BaseProjectCard{
  RecentActivityCard() : super("Recenty Activity");

  @override
  Widget setChildren() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RecentActivityDetailsCard(),
        _RecentActivityDetailsCard(),
        _RecentActivityDetailsCard()

      ],
    );
  }
}

class _RecentActivityDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                height: 30.0,
                width: 30.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image : AssetImage("assets/images.jpeg"),
                        fit: BoxFit.cover
                    )
                )
            ),
            Column(
              children: <Widget>[
                Text("Whaaaaaaaaaaaa"),
                Text("Whaaaaaaaaaaaa"),

              ],
            )


          ],
        )
    );
  }
}



