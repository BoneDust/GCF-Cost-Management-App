import 'dart:io';

import 'package:cm_mobile/screen/users/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormFields extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormFields();
  }
}

class _FormFields extends State<FormFields> {
  bool _obscureText = true;

  List<String> _privileges = <String>['', 'admin', 'foreman'];
  String _privilege = '';

  String _password;
  Widget previewImage;
  File _image;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    previewImage = Container(
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        onPressed: () {
          getImage();
        },
      ),
    );
    super.initState();
  }

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
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: FileImage(_image), fit: BoxFit.cover)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        new ListTile(
          leading: previewImage,
          title: TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'Full name'),
          ),
        ),
        new ListTile(
          title: TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'Username'),
          ),
        ),
        new ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  _toggle();
                },
              ),
            ),
            validator: (val) => val.length < 6 ? 'Password too short.' : null,
            onSaved: (val) => _password = val,
            obscureText: _obscureText,
          ),
        ),
        new ListTile(
          title: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: 'Contact Number',
            ),
          ),
        ),
        new ListTile(
          contentPadding: EdgeInsets.only(left: 17.0, right: 17.0),
          title: new FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                  labelText: 'Select privilege',
                ),
                isEmpty: _privilege == '',
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: _privilege,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        // newContact.favoriteprivilege = newValue;
                        _privilege = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _privileges.map((String value) {
                      return new DropdownMenuItem(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
