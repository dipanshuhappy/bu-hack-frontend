import 'package:BUPLAY/utils/Widgets/Button.dart';
import 'package:flutter/material.dart';

import '../Styles.dart';
import 'Scrollable_Text.dart';

class Event_Card extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventVenue;
  final String eventDescription;
  final Image eventImage;
  final String buttonText;
  final Function onButtonPress;
  const Event_Card(
      {required this.eventName,
      required this.eventDate,
      required this.eventTime,
      required this.eventVenue,
      required this.eventDescription,
      required this.eventImage,
      required this.buttonText,
      required this.onButtonPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width*0.8,
      child: Stack(children: [
        Container(
          height: 500,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: kDarkTextStyle.copyWith(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            eventDate,
                            style: kDarkTextStyle.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            eventTime,
                            style: kDarkTextStyle.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        eventVenue,
                        style: kDarkTextStyle.copyWith(
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10,),
                      const Text('Description', style: kDarkTextStyle),
                      const SizedBox(height: 10,),
                      ScrollableText(eventDescription: eventDescription),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          BasicButton(onPress: (){}, buttonText: 'Register'),
                          const SizedBox(width: 10),
                          BasicButton(onPress: (){}, buttonText: 'Volunteer'),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        )
      ]),
    );
  }
}

