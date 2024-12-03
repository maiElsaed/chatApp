import 'package:chatapp/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widget/constants.dart';
import '../widget/custom_button.dart';
import '../widget/custom_snackBar.dart';
import '../widget/custom_text_form_field.dart';
import '../widget/login_widget.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;
  bool check_login = false;
  GlobalKey<FormState> globalKey = GlobalKey();
  bool _isLoad = false;
  String AlertText="";
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoad,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: SingleChildScrollView(
          //  alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: globalKey,
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
                          right: MediaQuery.of(context).size.width * .68),
                      // padding: EdgeInsets.,
                      child: textWidget("Login", 25)),
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
                    type: "password",
                    ObscureText: true,
                    onChange: (data) {
                      password = data;
                    },
                  ),
                  SizedBox_Widget(.04),
                  Center(
                    child: Text(
                      AlertText,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: MediaQuery.of(context).size.width * .1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomButton(
                      text: "Sign Up",
                      action: () async {
                        if (globalKey.currentState!.validate()) {
                          setState(() {
                            _isLoad = true;
                          });
                          try {
                            await login(email!, password!);
                            CustomSnackBar(context, "Login good");
                            Navigator.pushNamed(context, ChatPage.id,
                                arguments: email);
                            check_login=true;
                            setState(() {
                              check_login=false;
                              AlertText="";
                            });
                          } on FirebaseAuthException catch (e) {

                            setState(() {
                              check_login=false;
                              AlertText="incorrect Email or password ";
                            });
                            print(
                                "///////////////////////////////////////////");
                            if (e.code == 'user-not-found') {
                              print(
                                  "first///////////////////////////////////////////");
                              CustomSnackBar(
                                  context, "No user found for that email.");
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print(
                                  "second///////////////////////////////////////////");

                              CustomSnackBar(context,
                                  "Wrong password provided for that user.");
                              print('Wrong password provided for that user.');
                            } else {
                              print(
                                  "mmmm/////////////////////////////////${e.code}");
                              print(
                                  "mmmm/////////////////////////////////${e.credential}");
                            }
                          }
                        }
                        setState(() {
                          _isLoad = false;
                        });
                      },
                    ),
                  ),
                  SizedBox_Widget(.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: textWidget("Not have an account ?", 15)),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: textWidget(" go to Register", 15))
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

Future<void> login(String email, String password) async {
  var auth = FirebaseAuth.instance;
  UserCredential credential = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  // print("credential.user"+credential.user.toString());
  //  print("credential"+credential.toString());
  //  print("credential.additionalUserInfo"+credential.additionalUserInfo.toString());
}
