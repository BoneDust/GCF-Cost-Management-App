import 'package:flutter/material.dart';

class CreateUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create new user'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Form(
            child: null,
          );
        },
        itemCount: 1,
      ),
    );
  }
}
