import 'dart:math';

import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/quotes.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar();

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  //  Function? onTap;
  int qouteIndex = 0;
  getRandomQuote() {
    Random random = Random();
    setState(() {
      qouteIndex = random.nextInt(6);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getRandomQuote();
      },
      child: Container(
          child: Text(
        sweetSayings[qouteIndex],
        style: TextStyle(fontSize: 22),
      )),
    );
  }
}
