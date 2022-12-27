import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/components/custom_textfield.dart';
import 'package:women_safety_app/components/primary_button.dart';
import 'package:women_safety_app/components/secondary_cutton.dart';
import 'package:women_safety_app/model/user_model.dart';
import 'package:women_safety_app/screens/child/child_login_screen.dart';
import 'package:women_safety_app/screens/child/register_as_child.dart';
import 'package:women_safety_app/utils/constant.dart';
import 'package:women_safety_app/utils/images.dart';

class RegisterParentScreen extends StatefulWidget {
  @override
  State<RegisterParentScreen> createState() => _RegisteParentScreenState();
}

class _RegisteParentScreenState extends State<RegisterParentScreen> {
  bool isPasswordShown = true;
  bool isRetypePassShow = true;

  final _formkey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();
  bool isloading = false;

  _onSubmit() async {
    _formkey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      dialogue(context, "password and retype password should be equal");
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isloading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _formData['gemail'].toString(),
                password: _formData['password'].toString());
        if (userCredential.user != null) {
          final v = userCredential.user!.uid;
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v);
          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            childEmail: _formData['cemail'].toString(),
            parentEmail: _formData['gemail'].toString(),
            id: v,
            usertype: 'parent',
          );
          // final json = {
          //   'id': v.user!.uid,
          //   'name': _formData['name'],
          // };
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            goto(
              context,
              LoginScreen(),
            );
            setState(() {
              isloading = false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading = false;
        });
        if (e.code == 'weak-password') {
          dialogue(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          dialogue(context, 'The account already exists for that email.');
        }
      } catch (e) {
        setState(() {
          isloading = true;
        });
        dialogue(context, e.toString());
        print(e);
      }
    }
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
                                  "Register as Parent",
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
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomtextField(
                                    hintText: "Enter Name",
                                    prefix: Icon(Icons.person),
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.name,
                                    onsave: (name) {
                                      _formData['name'] = name ?? " ";
                                    },
                                    validate: (name) {
                                      if (name!.isEmpty) {
                                        return "enter Name";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomtextField(
                                    hintText: "Enter Email",
                                    prefix: Icon(Icons.person),
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    onsave: (gemail) {
                                      _formData['gemail'] = gemail ?? " ";
                                    },
                                    validate: (gemail) {
                                      if (gemail!.isEmpty ||
                                          gemail.length < 3 ||
                                          !gemail.contains("@")) {
                                        return "enter Email";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomtextField(
                                    hintText: "Enter child email",
                                    prefix: Icon(Icons.person),
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    onsave: (cemail) {
                                      _formData['cemail'] = cemail ?? " ";
                                    },
                                    validate: (cemail) {
                                      if (cemail!.isEmpty ||
                                          cemail.length < 3 ||
                                          !cemail.contains("@")) {
                                        return "enter child Email";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomtextField(
                                    hintText: "Enter Phone",
                                    prefix: Icon(Icons.phone),
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.phone,
                                    onsave: (phone) {
                                      _formData['phone'] = phone ?? " ";
                                    },
                                    validate: (phone) {
                                      if ((phone!.isEmpty) ||
                                          (phone.length < 10)) {
                                        return "enter Phone";
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
                                  CustomtextField(
                                    hintText: "retype Password",
                                    isPassword: isRetypePassShow,
                                    onsave: (rpassword) {
                                      _formData['rpassword'] = rpassword ?? " ";
                                    },
                                    prefix: Icon(Icons.vpn_key_rounded),
                                    suffix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isRetypePassShow = !isRetypePassShow;
                                        });
                                      },
                                      icon: isRetypePassShow
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
                                    title: "Register",
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SecondaryButton(
                              title: "Login with your account",
                              onPressed: () {
                                goto(context, LoginScreen());
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
