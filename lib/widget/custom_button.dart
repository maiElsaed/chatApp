import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
   CustomButton({required this.text,required this.action});
   VoidCallback action;
   String text;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:action ,
      child: Container(
        width:double.infinity,
        //height: MediaQuery.of(context).size.height*.03,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        //child:textWidget("Sign Up",30),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 30,
            color: Color(0xff007090),
            //backgroundColor: Colors.amber
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
