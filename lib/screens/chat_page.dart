import 'package:flutter/material.dart';
import '../models/chatmodel.dart';
import '../widget/constants.dart';
import '../widget/custom_chat_puble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  static String id = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String chat = "";

  bool checkChat = false;

  TextEditingController textEditingController = TextEditingController();

  final _controllers = ScrollController();

  @override
  Widget build(BuildContext context) {
    String arguments = ModalRoute.of(context)!.settings.arguments as String;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chat",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: users.orderBy("createdAt", descending: true).snapshots(),
          builder: (context, snapshot) {
            List<Messages> ListMessages = [];
            // print(snapshot.data.docs.)
            if (snapshot.hasData) {
              for (int index = 0; index < snapshot.data!.docs.length; index++) {
                ListMessages.add(Messages.fromJson(snapshot.data!.docs[index]));
                //print(ListMessages[index].email);
                print(
                    "//////////////////////////////////////////////////////////////////////////");
              }
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _controllers,
                          itemCount: ListMessages.length,
                          itemBuilder: (context, index) {
                            return ListMessages[index].email == arguments
                                ? CustomChatPuble(
                                    messages: ListMessages[index],
                                  )
                                : CustomFriendChatPuble(
                                    messages: ListMessages[index],
                                  );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Expanded(
                          child: TextField(
                            controller: textEditingController,
                            onChanged: (value) {
                              setState(() {
                                chat = value.trim();
                              });

                            },
                            decoration: InputDecoration(
                                hintText: "Send Message",
                                suffixIcon: IconButton(
                                    onPressed: chat.isNotEmpty ? () {
                                      users
                                          .add({
                                        'message': '$chat',
                                        'createdAt': DateTime.now(),
                                        'email': arguments
                                      })
                                          .then((value) => print("User Added"))
                                          .catchError((error) =>
                                          print("Failed to add user: $error"));
                                      textEditingController.clear();
                                      _controllers.animateTo(0,
                                          duration: Duration(seconds: 3),
                                          curve: Curves.easeIn);
                                      setState(() {
                                        chat="";
                                      });
                                    } : null,
                                    icon: Icon(
                                      Icons.send,
                                      color: chat.isNotEmpty
                                          ? Colors.blue
                                          : Colors.grey,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(color: Colors.black87)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(color: Colors.black87))),
                          ),
                        ),
                      )
                    ],
                  ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
