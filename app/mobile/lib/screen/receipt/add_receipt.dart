import 'dart:io';

import 'package:cm_mobile/screen/receipt/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AddReceiptWidget(),
    );
  }
}

class _AddReceiptWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddReceiptState();
  }
}

class _AddReceiptState extends State<_AddReceiptWidget> {
  Widget previewImage = Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.4, 0.5, 1],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.white,
            Colors.white24,
            Colors.white30,
            Colors.grey.withOpacity(0.5),
          ],
        )
    ),
  );
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      previewImage = GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReceiptImageViewer(
                        image: _image,
                      )));
        },
        child: Image(
          image: FileImage(_image),
          fit: BoxFit.cover,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          elevation: 5,
          forceElevated: true,
          pinned: true,
          expandedHeight: 200.0,
          flexibleSpace: new FlexibleSpaceBar(
            centerTitle: true,
            background: previewImage,
            title: _buildRoundButton(Icons.add_a_photo, "take receipt picture"),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([_ReceiptFields()]),
          ),
        ),
      ],
    );
  }

  Widget _buildRoundButton(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              getImage();
              setState(() {});
            }),
        Text(title)
      ],
    );
  }
}

class _ReceiptFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "amount",
                prefix: Text("R")
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "supplier"),
            ),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "description",
              ),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                    elevation: 10,
                    color: Colors.blueGrey,
                    child: Text("submit", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    onPressed: () {
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
