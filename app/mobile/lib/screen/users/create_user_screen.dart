import 'dart:io';

import 'package:cm_mobile/screen/users/form_fields.dart';
import 'package:cm_mobile/screen/users/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateUserScreenState();
  }
}

class CreateUserScreenState extends State<CreateUserScreen> {
  Widget previewImage = Center(
    child: Text(
      "User image",
      style: TextStyle(
          fontFamily: String.fromCharCode(3),
          fontStyle: FontStyle.italic,
          color: Colors.grey,
          fontSize: 20),
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
              title: IconButton(
                  color: Colors.blueAccent,
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {
                    getImage();
                    setState(() {});
                  }),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(2),
            sliver: SliverList(
              delegate: SliverChildListDelegate([FormFields()]),
            ),
          ),
        ],
      ),
    );
  }
}

// class _FormFields extends StatelessWidget {
//   // bool _obscureText = true;

//   // String _password;

//   // void _toggle() {
//   //   setState(() {
//   //     _obscureText = !_obscureText;
// //   //   });
// //   // }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10.0), labelText: 'Name'),
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10.0), labelText: 'Surname'),
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10.0), labelText: 'Username'),
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10.0),
//                 labelText: 'Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.remove_red_eye),
//                   onPressed: () {
//                     // _toggle();
//                   },
//                 ),
//               ),
//               validator: (val) => val.length < 6 ? 'Password too short.' : null,
//               // onSaved: (val) => _password = val,
//               // obscureText: _obscureText,
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10.0),
//                   labelText: 'Contact Number'),
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10.0),
//                   labelText: 'Select privilege'),
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 ButtonBar(
//                   children: <Widget>[
//                     RaisedButton(
//                       color: Colors.blue,
//                       onPressed: () {},
//                       child: Text(
//                         'Save',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
