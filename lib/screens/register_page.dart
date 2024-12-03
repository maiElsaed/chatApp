import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widget/constants.dart';
import '../widget/custom_button.dart';
import '../widget/custom_snackBar.dart';
import '../widget/custom_text_form_field.dart';
import '../widget/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  static String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoaded,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            //  alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox_Widget(.1),

                  Padding(
                      padding: EdgeInsets.all(0),
                      child: Image(
                        image: AssetImage('images/icon_chat.png'),
                        // alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .4,
                      ),
                    ),
                  
                  textWidget("Scholar Chat", 35),
                  SizedBox_Widget(.06),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * .6),
                    // padding: EdgeInsets.,
                    child: textWidget("Register", 25),
                  ),
                  SizedBox_Widget(.01),
                  CustomTextField(
                    hintText: "Email",
                    onChange: (data) {
                      email = data;
                    },
                  ),
                  SizedBox_Widget(.02),
                  CustomTextField(
                    hintText: "Password",
                    ObscureText: true,
                    type: "password",
                    onChange: (data) {
                      password = data;
                    },
                  ),
                  SizedBox_Widget(.04),
                  GestureDetector(
                    onTap: () {},
                    child: CustomButton(
                      text: "Register",
                      action: () async {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            _isLoaded = true;
                          });
                          try {
                            register(email!, password!);
                            CustomSnackBar(context, "registerd good");
                            Navigator.pushNamed(context, ChatPage.id,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              CustomSnackBar(context,
                                  "The password provided is too weak.");
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              CustomSnackBar(context,
                                  "The account already exists for that email.");
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            CustomSnackBar(context, e.toString());
                            print(e);
                          }
                        }
                        setState(() {
                          _isLoaded = false;
                        });
                      },
                    ),
                  ),
                  SizedBox_Widget(.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: textWidget("already have an account ?", 15)),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: textWidget(" go to Login", 15))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> register(String email, String password) async {
  print("///////////////////////////////check password ${email} ${password}");
  var auth = FirebaseAuth.instance;
  UserCredential credential = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  print("/./././.././././././ ${credential}");
  // print("credential.user"+credential.user.toString());
  //  print("credential"+credential.toString());
  //  print("credential.additionalUserInfo"+credential.additionalUserInfo.toString());
}
