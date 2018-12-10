import 'dart:io';

import 'package:cm_mobile/screen/foreman/receipt/image_viewer.dart';
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

  Widget previewImage = Center(
    child: Text("Take receipt picture",
      style: TextStyle(
        fontFamily: String.fromCharCode(3),
        fontStyle: FontStyle.italic,
        color: Colors.grey,
        fontSize: 20
      ),),
  );
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      previewImage = GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptImageViewer(image: _image,)));
        },
        child: Image(
          image: FileImage(_image),
          fit: BoxFit.fill,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.black26,
      child: CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            backgroundColor: Colors.blueGrey,
            floating: true,
            expandedHeight: 300.0,
            flexibleSpace: new FlexibleSpaceBar(
              background: previewImage,
              title: IconButton(color: Colors.blueAccent,
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {
                    getImage();
                    setState(() {

                    });
                  }),
            ),
          ),

          SliverPadding(
            padding:  EdgeInsets.all(20),
            sliver:  SliverList(
              delegate:  SliverChildListDelegate([
                _ReceiptFields()
              ]),
            ),
          ),
        ],
      ),
    );
  }

}

class _ReceiptFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Amount. Eg. 100",
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Supplier"
              ),
            ),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  labelText: "Description",
              ),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(child : Text("Submit"), onPressed: () {},)
              ],
            )
          ],
        ),
      ),
    );
  }
}

