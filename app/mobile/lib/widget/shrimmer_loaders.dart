import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShrimmerMenuList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.red
              ),
            )
          ],
        ),
      ),
    );
    ;
  }

}