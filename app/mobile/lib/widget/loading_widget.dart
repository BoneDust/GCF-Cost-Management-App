import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String text;

  const LoadingIndicator({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(backgroundColor: Colors.green,),
                text != null ? Text(text) : Column()
              ],
            ),
          ),
        ],
      ),
    );
  }
}