import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  SecondaryButton({required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: (() {
          onPressed();
        }),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
