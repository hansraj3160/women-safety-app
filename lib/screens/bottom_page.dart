import 'package:flutter/material.dart';
import 'package:women_safety_app/screens/bottom_screen/chat_page.dart';
import 'package:women_safety_app/screens/bottom_screen/contact_page.dart';
import 'package:women_safety_app/screens/bottom_screen/profile_page.dart';
import 'package:women_safety_app/screens/bottom_screen/review_page.dart';
import 'package:women_safety_app/screens/home_page.dart';
import 'package:women_safety_app/utils/constant.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    ContactPage(),
    ChatPage(),
    ProfilePage(),
    ReviewPage()
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.blue,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home,
                  color: primaryColor,
                )),
            BottomNavigationBarItem(
                label: "Contact",
                icon: Icon(
                  Icons.contacts,
                  color: primaryColor,
                )),
            BottomNavigationBarItem(
                label: "Chats",
                icon: Icon(
                  Icons.chat,
                  color: primaryColor,
                )),
            BottomNavigationBarItem(
                label: "Person",
                icon: Icon(
                  Icons.person,
                  color: primaryColor,
                )),
            BottomNavigationBarItem(
                label: "Review",
                icon: Icon(
                  Icons.reviews,
                  color: primaryColor,
                )),
          ]),
    );
  }
}
