import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_app/utils/constant.dart';
import 'package:women_safety_app/utils/images.dart';
import 'package:women_safety_app/widgets/home_widget/liveSafe/live_Safe_card.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          LiveSafeCustomCard(
            strlocation: MapText.pLocationLiveSafe,
            imgPath: Images.policeBadge,
            bottomText: LiveSafeC.pLiveSafe,
          ),
          LiveSafeCustomCard(
            strlocation: MapText.hLocationLiveSafe,
            imgPath: Images.hospital,
            bottomText: LiveSafeC.hLiveSafe,
          ),
          LiveSafeCustomCard(
            strlocation: MapText.pharmacyLocationLiveSafe,
            imgPath: Images.ambulance,
            bottomText: LiveSafeC.pharmacyLiveSafe,
          ),
          LiveSafeCustomCard(
            strlocation: MapText.busLocationLiveSafe,
            imgPath: Images.busStop,
            bottomText: LiveSafeC.busLiveSafe,
          ),
        ],
      ),
    );
  }
}
