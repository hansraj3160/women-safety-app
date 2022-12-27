import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/screens/child/register_as_child.dart';

class EmergencyText {
  static const String pEText1 = "Active Emergency";
  static const String pEText2 = "call 0-1-5 for emergencies";
  static const String pEText3 = "0-1-5";
  static const String pPhone = "15";
  static const String aEText1 = "Ambulace";
  static const String aEText2 = "In case of medical emergency call";
  static const String aEText3 = "1 -1 -2 -2";
  static const String aPhone = "1122";
  static const String fEText1 = "Fire brigade";
  static const String fEText2 = "In case of fire emergency call";
  static const String fEText3 = "0 -1 -6";
  static const String fPhone = "16";
  static const String armyEText1 = "NACTA";
  static const String armyEText2 = "National counter Terrorsim Authority";
  static const String armyEText3 = "1 -7 -1 -7";
  static const String armyPhone = "1717";
}

class LiveSafeC {
  static const String pLiveSafe = "Police Stations";
  static const String hLiveSafe = 'Hospitals';
  static const String pharmacyLiveSafe = 'Pharmacy';
  static const String busLiveSafe = 'Bus Station';
}

class MapText {
  static const String pLocationLiveSafe = "Police Stations near me";
  static const String hLocationLiveSafe = 'Hospitals near me';
  static const String pharmacyLocationLiveSafe = 'Pharmacy near me';
  static const String busLocationLiveSafe = 'Bus Station near me';
}

Color primaryColor = Color(0xfffc3b77);

void goto(BuildContext context, Widget nextScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => nextScreen,
    ),
  );
}

dialogue(BuildContext context, String titleText) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titleText),
    ),
  );
}

Widget progressIndicator(BuildContext context) {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: primaryColor,
    color: Colors.red,
    strokeWidth: 7,
  ));
}
