import 'dart:io';

import 'package:cm_mobile/screen/users/form_fields.dart';
import 'package:cm_mobile/screen/users/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CreateUserScreen(),
    );
  }
}

class _CreateUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateUserScreenState();
  }
}

class _CreateUserScreenState extends State<_CreateUserScreen> {
  Widget previewImage = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.4, 0.5, 1],
        colors: [
          Colors.white,
          Colors.white24,
          Colors.white30,
          Colors.grey.withOpacity(0.5),
        ],
      ),
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
                  builder: (context) => ProfileImageViewer(
                        image: _image,
                      )));
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
    return CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          elevation: 5,
          forceElevated: true,
          pinned: true,
          flexibleSpace: new FlexibleSpaceBar(
            title: Text("add new user"),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(5.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([FormFields()]),
          ),
        )
      ],
    );
  }

  // Widget _buildRoundButton(IconData icon, String title) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisSize: MainAxisSize.min,
  //     children: <Widget>[
  //       IconButton(
  //           icon: Icon(Icons.add_a_photo),
  //           onPressed: () {
  //             getImage();
  //             setState(() {});
  //           }),
  //       Text(title)
  //     ],
  //   );
  // }
}
