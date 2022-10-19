import 'package:BUPLAY/utils/Styles.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonText;
  final Color buttonColor;
  final double vPadding;
  final double hPadding;
  final double round;
  BasicButton(
      {Key? key,
      required this.onPress,
      required this.buttonText,
      this.buttonColor = Colors.deepPurple,
      this.vPadding = 15,
      this.hPadding = 15,
      this.round = 10
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(round),
          ),
          child: Text(
            buttonText,
          ),
        ));
  }
}

class BasicButtonWithIcon extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonText;
  final Icon icon;
  final double width;
  final Color buttonColor;
  final double vPadding;
  final double hPadding;
  final double round;
  BasicButtonWithIcon(
      {Key? key,
        required this.onPress,
        required this.buttonText,
        required this.icon,
        this.width = 130,
        this.buttonColor = Colors.deepPurple,
        this.vPadding = 15,
        this.hPadding = 15,
        this.round = 10
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(round),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
              ),
              const SizedBox(width: 10),
              icon
            ],
          ),
        ));
  }
}
