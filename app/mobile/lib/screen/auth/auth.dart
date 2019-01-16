import 'dart:async';
import 'dart:ui';

import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/service/api_auth_service.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  StreamSubscription listener;
  bool _autoValidate = false;
  AuthBloc authBloc;

  String _errorText = "";

  bool _isLoading = false;

  @override
  void initState() {
    authBloc = AuthBloc(AuthApiService());
    listener = authBloc.outLogin.listen(_loginResult);
    listener.onError(handleError);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final _formKey = GlobalKey<FormState>();
    AppDataContainerState appDataContainerState = AppDataContainer.of(context);
    AuthenticationState authState = appDataContainerState.authState;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/header.jpg',
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 300,
              child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        child: Image(
                            image: AssetImage("assets/gcf_logo_white.png")),
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 12.0),
                      Theme(
                          data: themeData.copyWith(
                            hintColor: Colors.white,
                            primaryColor: Colors.green
                          ),
                          child: Column(
                            children: <Widget>[
                              _buildTextFormField("username",
                                  _usernameController, usernameValidator),
                              Padding(
                                padding: EdgeInsets.only(bottom: 30),
                              ),
                              _buildTextPwdFormField("password",
                                  _passwordController, passwordValidator),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          _errorText,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        child: RaisedButton(
                          textColor: Colors.black,
                          child: Text('sign in'),
                          color: Colors.white,
                          elevation: 10.0,
                          shape: StadiumBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _isLoading = true;
                              appDataContainerState
                                  .setAuthState(AuthenticationState.loading());
                              authBloc.authenticateUser(UserLogin());
                            } else
                              setState(() {
                                _autoValidate = true;
                              });
                          },
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'forgot password',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )),
            ),
          ),
        ),
        _isLoading ? LoadingIndicator() : Column()
      ],
    );
  }

  Widget _buildTextFormField(
      String labelText, TextEditingController controller, Function validator) {
    return TextFormField(
      validator: validator,
      autovalidate: _autoValidate,
      controller: controller,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );
  }

  Widget _buildTextPwdFormField(
      String labelText, TextEditingController controller, Function validator) {
    return TextFormField(
      validator: validator,
      autovalidate: _autoValidate,
      controller: controller,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      obscureText: true,
    );
  }

  String usernameValidator(String value) {
    if (value.isEmpty) return "username cannot be empty";
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) return "passsword cannot be empty";
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    listener?.cancel();
  }

  void _loginResult(User user) {
    AppDataContainerState dataContainerState = AppDataContainer.of(context);
    if (user != null) {
      dataContainerState.user = user;
      dataContainerState.setAuthState(AuthenticationState.authenticated());
    }
  }

  handleError(error) {
    setState(() {
      _isLoading = false;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("$error"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("ok"))
            ],
          );
        });
  }
}
