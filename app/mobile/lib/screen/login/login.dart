import 'package:cm_mobile/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = LoginBloc();

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      children: <Widget>[
        SizedBox(height: 80.0),
        Column(
          children: <Widget>[
            //   Image.asset('assets/diamond.png'),
            SizedBox(height: 16.0),
            Text(
              'GCF',
              style: Theme.of(context).textTheme.headline,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
          ),
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('Forgot password'),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              onPressed: () {
                //TODO
              },
            ),
            RaisedButton(
              child: Text('LOG IN'),
              elevation: 8.0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/Home");
              },
            ),
          ],
        ),
      ],
    )));
  }

  Widget _loadingIndicator() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
