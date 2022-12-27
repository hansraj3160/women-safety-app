import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/db/shared_pref.dart';
import 'package:women_safety_app/screens/bottom_page.dart';
import 'package:women_safety_app/screens/child/child_login_screen.dart';
import 'package:women_safety_app/screens/home_page.dart';
import 'package:women_safety_app/screens/parents/parent_home.dart';
import 'package:women_safety_app/utils/constant.dart';

void options() {
  final FirebaseApp app = Firebase.app();
  final options = app.options;
  print('Current options for app ${app.name}: $options');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPrefference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.firaSansTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: MySharedPrefference.getUserType(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == "") {
                return LoginScreen();
              }
              if (snapshot.data == "child") {
                return BottomPage();
              }
              if (snapshot.data == "parent") {
                return ParentHomeScreen();
              }
              return progressIndicator(context);
            }));
  }
}

class CheckAuth extends StatelessWidget {
  // const CheckAuth({Key? key}) : super(key: key);

  checkData() {
    if (MySharedPrefference.getUserType() == 'parent') ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
