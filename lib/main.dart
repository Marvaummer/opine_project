
import 'package:flutter/material.dart';
import 'package:opine_project/view/categories.dart';
import 'package:opine_project/view/fooditems.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Categories(),
    );
  }
}
