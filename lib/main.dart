import 'package:flutter/material.dart';
import 'package:kidsfirstgame/pages/home.dart';

main() => runApp(const Myapp());

class Myapp extends StatelessWidget {
  const Myapp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}