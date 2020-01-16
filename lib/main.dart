import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/ui/Login_Page.dart';
import 'package:the_gorgeous_login/ui/Personal_details.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SixNapoleon',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new Personal(),
    );
  }
}