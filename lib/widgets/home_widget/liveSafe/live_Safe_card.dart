import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSafeCustomCard extends StatelessWidget {
  String strlocation;
  String imgPath;
  String bottomText;
  LiveSafeCustomCard(
      {Key? key,
      required this.strlocation,
      required this.imgPath,
      required this.bottomText})
      : super(key: key);

  static Future<void> openMap(String Location) async {
    String googleUrl = "https://www.google.com/maps/search/$Location";
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "something went wrong! call emergency number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              openMap(strlocation);
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                    child: Image.asset(
                  imgPath,
                  height: 32,
                )),
              ),
            ),
          ),
          Text(bottomText)
        ],
      ),
    );
  }
}
