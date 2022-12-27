import 'package:flutter/material.dart';

class ParentHomeScreen extends StatefulWidget {
  ParentHomeScreen({Key? key}) : super(key: key);

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Parent Screen"),
      ),
    );
  }
}
