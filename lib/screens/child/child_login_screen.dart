import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/components/custom_textfield.dart';
import 'package:women_safety_app/components/primary_button.dart';
import 'package:women_safety_app/components/secondary_cutton.dart';
import 'package:women_safety_app/db/shared_pref.dart';
import 'package:women_safety_app/screens/child/register_as_child.dart';
import 'package:women_safety_app/screens/home_page.dart';
import 'package:women_safety_app/screens/parents/parent_home.dart';
import 'package:women_safety_app/screens/parents/parents_register_screen.dart';
import 'package:women_safety_app/utils/constant.dart';
import 'package:women_safety_app/utils/images.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = true;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isloading = false;
  _onSubmit() async {
    _formkey.currentState!.save();

    try {
      setState(() {
        isloading = true;
      });
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _formData['email'].toString(),
        password: _formData['password'].toString(),
      );
      if (credential.user != null) {
        setState(() {
          isloading = false;
        });
        FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .get()
            .then((value) {
          if (value['type'] == 'parent') {
            MySharedPrefference.saveUserType('parent');
            goto(context, ParentHomeScreen());
          } else {
            MySharedPrefference.saveUserType('child');
            goto(context, HomeScreen());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading = false;
      });
      if (e.code == 'user-not-found') {
        dialogue(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialogue(context, 'Wrong password provided for that user.');
      }
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              isloading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "User LogIn",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfffc3b77),
                                  ),
                                ),
                                Image.asset(
                                  Images.logo,
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomtextField(
                                    hintText: "Enter email",
                                    prefix: Icon(Icons.person),
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    onsave: (email) {
                                      _formData['email'] = email ?? " ";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return "enter Correct Email";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomtextField(
                                    hintText: "Enter Password",
                                    isPassword: isPasswordShown,
                                    onsave: (password) {
                                      _formData['password'] = password ?? " ";
                                    },
                                    prefix: Icon(Icons.vpn_key_rounded),
                                    suffix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordShown = !isPasswordShown;
                                        });
                                      },
                                      icon: isPasswordShown
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    ),
                                    validate: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return "enter Correct password";
                                      }
                                      return null;
                                    },
                                  ),
                                  PrimaryButton(
                                    title: "Login",
                                    onPressed: () {
                                      // progressIndicator(context);
                                      if (_formkey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SecondaryButton(
                                title: "Click here",
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SecondaryButton(
                              title: "Register as Child",
                              onPressed: () {
                                goto(context, RegisterChildScreen());
                              }),
                          SecondaryButton(
                              title: "Register as Parent",
                              onPressed: () {
                                goto(context, RegisterParentScreen());
                              }),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
