import 'package:flutter/material.dart';

ScaffoldFeatureController CustomSnackBar(BuildContext context,String message){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message,style: TextStyle(color: Colors.black87),))
  );
}