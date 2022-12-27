import 'package:flutter/material.dart';
import 'package:women_safety_app/widgets/home_widget/custom_appbar.dart';
import 'package:women_safety_app/widgets/home_widget/custom_carouel.dart';
import 'package:women_safety_app/widgets/home_widget/emergency.dart';
import 'package:women_safety_app/widgets/home_widget/liveSafe/live_safe.dart';
import 'package:women_safety_app/widgets/home_widget/safeHome/safe_home.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CustomCarouel(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Emergency",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  EmergencyWidget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Explore LiveSafe",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  LiveSafe(),
                  SafeHome(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
