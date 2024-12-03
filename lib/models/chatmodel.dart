import 'package:flutter/material.dart';
class Messages  {

  String message;
  String email;
  Messages({required this.message,required this.email});
  factory Messages.fromJson(jsondata){
    return Messages(
      message: jsondata['message'],
      email: jsondata['email']
    );
  }
}
