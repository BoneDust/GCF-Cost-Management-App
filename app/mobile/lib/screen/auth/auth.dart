import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user_login.dart';
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

  bool _autoValidate = false;

  String _errorText = "";

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    ThemeData themeData = Theme.of(context);
    final _formKey = GlobalKey<FormState>();
    authBloc.results
        .listen((authState) => onError(authState));

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
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
            Center(
              child: Container(
                width: 300,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
            )
          ],
        ));
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

  Widget _buildTextFormField(
      String labelText, TextEditingController controller, Function validator) {
    return TextFormField(
      validator: validator,
      autovalidate: _autoValidate,

      controller: controller,

      style: TextStyle(color: Colors.white,),
      decoration: InputDecoration(
          labelText: 'username',
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
}