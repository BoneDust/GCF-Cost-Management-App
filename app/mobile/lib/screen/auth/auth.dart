import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    ThemeData themeData = Theme.of(context);

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
             child:  Container(
               width: 300,
               child:  Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     child: Image(image: AssetImage("assets/gcf_logo_white.png")),
                     height: 80,
                     width: 80,
                   ),
                   const SizedBox(height: 12.0),
                   Theme(
                       data: themeData.copyWith(
                         hintColor: Colors.white,),
                       child: Column(
                         children: <Widget>[
                           TextField(
                             controller: _usernameController,
                             style: TextStyle(color: Colors.white),
                             decoration: InputDecoration(
                                 labelText: 'Username',
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(25))),

                           ),
                           Padding(padding: EdgeInsets.only(bottom: 30),),
                           TextField(
                             controller: _passwordController,
                             decoration: InputDecoration(
                               labelText: 'Password',
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(25))
                             ),
                             obscureText: true,
                           ),
                         ],
                       )),
                   Padding(padding: EdgeInsets.only(bottom: 30),),

                   Container(
                     width: double.infinity,
                     height: 55,
                     child: RaisedButton(
                       child: Text('LOG IN'),
                       color: Colors.white,
                       elevation: 8.0,
                       highlightElevation: 6,
                       highlightColor: Colors.red,
                       shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                       onPressed: () {
                         authBloc.authenticateUser(UserLogin());
                       },
                     )
                     ,
                   ),
                   FlatButton(
                     child: Text('Forgot password', style: TextStyle(color: Colors.white),),
                     shape: BeveledRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(7.0)),
                     ),
                     onPressed: () {
                       //TODO
                     },
                   ),
                 ],
               ),
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
}
//Container(
//decoration: BoxDecoration(
//gradient: LinearGradient(
//
//colors: [Colors.white, Colors.black, Colors.black12]),
//),
//child: ListView(
//padding: EdgeInsets.symmetric(horizontal: 24.0),
//children: <Widget>[
//SizedBox(height: 80.0),
//Column(
//children: <Widget>[
//Image(image: AssetImage("assets/gcf_logo.png")),
//SizedBox(height: 16.0),
//],
//),
//const SizedBox(height: 12.0),
//TextField(
//controller: _usernameController,
//decoration: InputDecoration(
//labelText: 'Username',
//),
//),
//TextField(
//controller: _passwordController,
//decoration: InputDecoration(
//labelText: 'Password',
//),
//obscureText: true,
//),
//ButtonBar(
//children: <Widget>[
//FlatButton(
//child: Text('Forgot password'),
//shape: BeveledRectangleBorder(
//borderRadius: BorderRadius.all(Radius.circular(7.0)),
//),
//onPressed: () {
////TODO
//},
//),
//RaisedButton(
//child: Text('LOG IN'),
//elevation: 8.0,
//shape: BeveledRectangleBorder(
//borderRadius: BorderRadius.all(Radius.circular(5.0)),
//),
//onPressed: () {
//authBloc.authenticateUser(UserLogin());
//},
//),
//],
//),
//],
//),
//)
