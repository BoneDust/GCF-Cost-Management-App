import 'package:flutter/material.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateUserScreenState();
  }
}

class CreateUserScreenState extends State<CreateUserScreen> {
  bool _obscureText = true;

  String _password;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create new user'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Form(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Name'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Surname'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Username'),
                  ),
                  TextFormField(
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
                    validator: (val) =>
                        val.length < 6 ? 'Password too short.' : null,
                    onSaved: (val) => _password = val,
                    obscureText: _obscureText,
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.all(10.0),
                  //       labelText: 'Upload Picture'),
                  // ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Contact Number'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Select privilege'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {},
                        child: Text(
                          'Upload Image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
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
              ),
            ),
          );
        },
        itemCount: 1,
      ),
    );
  }
}
