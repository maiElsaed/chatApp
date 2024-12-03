import 'package:flutter/material.dart';
Widget textWidget( String text, double font_size){
  return  Text(
    text,
    style: TextStyle(
      fontSize: font_size,
      color: Colors.white,
      //backgroundColor: Colors.amber
    ),
    textAlign: TextAlign.start,
  );
}
Widget SizedBox_Widget(double height){
  return Builder(
    builder: (context) {
      return SizedBox(height: MediaQuery.of(context).size.height*height,);
    }
  );
}