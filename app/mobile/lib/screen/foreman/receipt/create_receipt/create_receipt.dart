import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ForeManCreateReceiptScreen extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ForeManCreateReceiptScreen(),
    );
  }
}

class _ForeManCreateReceiptScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForeManCreateReceiptState();
  }
}

class _ForeManCreateReceiptState extends State<_ForeManCreateReceiptScreen> {

  Widget previewImage = Center(child: Text("Take receipt picture"));
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      previewImage = Image(
        image: FileImage(_image),
        fit: BoxFit.fill,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          floating: true,
          expandedHeight: 300.0,
          flexibleSpace: new FlexibleSpaceBar(
            background: previewImage,
          ),
          bottom: PreferredSize(
              child: Flexible(child: IconButton(color: Colors.red,
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {
                    getImage();
                    setState(() {

                    });
                  }),)
              , preferredSize: Size(50, 50)),
        ),
        new SliverPadding(
          padding: new EdgeInsets.all(16.0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate([
              _ReceiptFields()
            ]),
          ),
        ),
      ],
    );
  }

}

class _ReceiptFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              labelText: "Amount. Eg. 100"
          ),
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Supplier"
          ),
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Description"
          ),
        )

      ],
    );
  }
}

