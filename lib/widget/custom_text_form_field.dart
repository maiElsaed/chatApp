import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.hintText, this.onChange,this.ObscureText=false,this.type="email"});
  String type;
  String hintText;
  bool ObscureText;
  Function(String)? onChange;
  final RegExp emailPattern = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if( value is Null || value.isEmpty ){
          return "this field required";
        }else if(type=="email"){
          if(emailPattern.hasMatch(value)==false){
            return ' please , enter valid email';
          }
        }else if(type=="password"){
          if(value.length<6){
            return 'password shoude be more than 6 digits';
          }
        }
      },
      onChanged: onChange,
      obscureText: ObscureText,
      decoration: InputDecoration(
        //hintText:"Email" ,
        label: Text(
          hintText,
          style: TextStyle(color: Colors.white),
        ),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
