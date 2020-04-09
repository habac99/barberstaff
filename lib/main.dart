import 'package:barberstaff/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:barberstaff/services/authentication.dart';


import 'package:barberstaff/pages/login.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new WelcomePage(auth: new Auth()));
  }
}