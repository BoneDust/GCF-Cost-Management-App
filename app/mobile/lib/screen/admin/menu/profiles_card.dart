import 'dart:math';

import 'package:flutter/material.dart';
import 'base_profile_card.dart';

class ProfilesCard extends BaseProfileCard {
  ProfilesCard() : super('Uploaded Receipts');

  @override
  Widget setChildren() {
    return _ProfilesCardRoot();
  }
}

class _ProfilesCardRoot extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ProfilesCardRoot() {
    baseTextStyle = const TextStyle();
    headerStyle = baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/AdminProfile");
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text("Profiles", style: headerStyle),
                    new Row(
                      children: <Widget>[
                        Text("4",
                            style: headerStyle.copyWith(color: Colors.grey)),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ],
                    )
                  ]),
            )),
        _ProfilesCard(),
      ],
    );
  }
}

class _ProfilesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      padding: EdgeInsetsDirectional.only(bottom: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _ProfileSampleCard("1"),
          _ProfileSampleCard("2"),
          _ProfileSampleCard("3"),
          _ProfileSampleCard("4"),
          _ProfileSampleCard("5"),
          _ProfileSampleCard("6")
        ],
      ),
    );
  }
}

class _ProfileSampleCard extends StatelessWidget {
  String title;
  static var rng = new Random();

  _ProfileSampleCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(left: 7),
      child: Card(
        child: Center(child: Text(title)),
        color: Color.fromARGB(rng.nextInt(255), rng.nextInt(255),
            rng.nextInt(255), rng.nextInt(255)),
      ),
    );
  }
}
