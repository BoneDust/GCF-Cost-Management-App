import 'dart:ui';

import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AuthScreen();
  }

}
class _AuthScreen extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var listener;
  bool _autoValidate = false;
  AuthBloc authBloc;

  String _errorText = "";

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    if (listener != null)
      listener = authBloc.results
          .listen((authState) => onError(authState));

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
                          ),
                          child: Column(
                            children: <Widget>[
                              _buildTextFormField(
                                  "username", _usernameController, usernameValidator),
                              Padding(
                                padding: EdgeInsets.only(bottom: 30),
                              ),
                              _buildTextFormField(
                                  "password", _passwordController, passwordValidator),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(_errorText, style: TextStyle(color: Colors.red),),
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        child: RaisedButton(
                          child: Text('sign in'),
                          color: Colors.white,
                          elevation: 10.0,
                          shape: StadiumBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              appDataContainerState.setAuthState(AuthenticationState.loading());
                              authBloc.authenticateUser(UserLogin());
                            }else
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(7.0)),
                        ),
                        onPressed: () {

                        },
                      ),
                    ],
                  )),
            ),
          ),
        ),
        authState.isLoading ? _loadingIndicator() : Column()
      ],
    );
  }

  Widget _loadingIndicator() {
    return Stack(
      children: <Widget>[
        Container(
          child:  BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child:  Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        Center(
          child: CircularProgressIndicator(backgroundColor: Colors.green,),
        ),
      ],
    );
  }

  Widget _buildTextFormField(
      String labelText, TextEditingController controller, Function validator) {
    return TextFormField(
      validator: validator,
      autovalidate: _autoValidate,

      controller: controller,

      style: TextStyle(color: Colors.white,),
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );
  }

  String usernameValidator(String value){
    if (value.isEmpty)
      return "username cannot be empty";
    return null;
  }
  String passwordValidator(String value){
    if (value.isEmpty)
      return "passsword cannot be empty";
    return null;
  }

  onError(AuthenticationState authState) {
    if (!authState.isAuthenticated){
      setState(() {
        _errorText = "username or password doesn't match";
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
    listener?.cancel();
  }
}