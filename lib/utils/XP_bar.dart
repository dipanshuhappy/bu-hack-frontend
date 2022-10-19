import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/studentCoin_details.dart';
import 'Styles.dart';


class XpBar extends StatelessWidget {
  final int xpPercent;
  FutureBuilder<StudentCoin> level;
  final double barWidth;
   XpBar({
    Key? key, required this.xpPercent, required this.level, this.barWidth = 190,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.deepPurple.shade100,
          child: level,

        ),
        Padding(
            padding: const EdgeInsets.all(0),
            child: LinearPercentIndicator(
              lineHeight: 25,
              percent: xpPercent / 100,
              progressColor: Colors.deepPurple,
              backgroundColor:
              Colors.deepPurple.shade100,
              width: barWidth,
              barRadius: const Radius.circular(20),
            )),
      ],
    );
  }
}
