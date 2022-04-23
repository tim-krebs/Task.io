import 'package:flutter/material.dart';

class TodoColor {
  final Color color;

  static const List<Color> predefinedColors = [
    Color(0xff7ec9f5),
    Color(0xff3957ed),
    Color(0xff65f4cd),
    Color(0xffa0b5eb),
    Color(0xffedaef9),
    Color.fromARGB(255, 250, 129, 129),
  ];

  TodoColor({required this.color});
}
