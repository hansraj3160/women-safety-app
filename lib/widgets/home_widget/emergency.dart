import "package:flutter/material.dart";
import 'package:women_safety_app/utils/constant.dart';
import 'package:women_safety_app/widgets/police_emergency.dart';
import 'package:women_safety_app/utils/images.dart';

class EmergencyWidget extends StatelessWidget {
  const EmergencyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          EmergencyWidgetCard(
            img: Images.alert,
            text1: EmergencyText.pEText1,
            text2: EmergencyText.pEText2,
            text3: EmergencyText.pEText3,
            phoneNumber: EmergencyText.pPhone,
          ),
          EmergencyWidgetCard(
            img: Images.ambulance,
            text1: EmergencyText.aEText1,
            text2: EmergencyText.aEText2,
            text3: EmergencyText.aEText3,
            phoneNumber: EmergencyText.aPhone,
          ),
          EmergencyWidgetCard(
            img: Images.flame,
            text1: EmergencyText.fEText1,
            text2: EmergencyText.fEText2,
            text3: EmergencyText.fEText3,
            phoneNumber: EmergencyText.fPhone,
          ),
          EmergencyWidgetCard(
            img: Images.army,
            text1: EmergencyText.armyEText1,
            text2: EmergencyText.armyEText2,
            text3: EmergencyText.armyEText3,
            phoneNumber: EmergencyText.armyPhone,
          ),
        ],
      ),
    );
  }
}
