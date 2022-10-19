import 'package:flutter/material.dart';

import '../Styles.dart';

class ScrollableText extends StatelessWidget {
  const ScrollableText({
    Key? key,
    required this.eventDescription,
  }) : super(key: key);

  final String eventDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                eventDescription,
                style: kDarkTextStyle.copyWith(
                    fontWeight: FontWeight.w300, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
