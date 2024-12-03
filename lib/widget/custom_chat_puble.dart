import 'package:flutter/material.dart';

import '../models/chatmodel.dart';
import 'constants.dart';

class CustomChatPuble extends StatelessWidget {
   CustomChatPuble({required this.messages});
  Messages messages;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          messages.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomFriendChatPuble extends StatelessWidget {
  CustomFriendChatPuble({required this.messages});
  Messages messages;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: KUserPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          messages.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
