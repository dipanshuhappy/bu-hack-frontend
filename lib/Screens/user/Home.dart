import 'dart:convert';
import 'package:BUPLAY/models/student_details.dart';
import 'package:BUPLAY/services/students_http.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/EventCard.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:BUPLAY/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/studentCoin_details.dart';
import '../../services/studentCoins_http.dart';
import '../../utils/XP_bar.dart';
import '../../utils/colors.dart';
import 'Profile_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int xpPercent = 50;
int level = 20;

showDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: const Text('Profile Page'),
          ),
        ],
      );
    },
  );
}

class _HomeScreenState extends State<HomeScreen> {
  String _studentId = "";
  @override
  initState() {
    print("this is  in init state");
    SharedPreferences.getInstance().then((prefs) {
      print("this is in init state with pref");
      setStudentId(prefs.getString(PREFERENCE_STUDENT_EMAIL));
    });

    super.initState();
  }

  void setStudentId(String? id) {
    setState(() {
      _studentId = id!;
    });
    print("${_studentId}this is the id");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: kDarkPrimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDialogBox(context);
                },
                child: FutureBuilder<StudentDetails>(
                  future: StudentDetailsHttp.getStudentDetail(_studentId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return StudentDetailView(
                        studentDetails: snapshot.data,
                        levelDetials: levelDetails(),
                        alphaCoinDetials: alphaCoinDetials(),
                        sigmaCoinDetails: sigmaCoinDetails(),
                      );
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(snapshot.error.toString());
                    }
                    return Container(height: 100, child: Text(''));
                    //Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '  Event List',
                style: kLightTextStyle.copyWith(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Event_Card(
                        eventName: "eventName",
                        eventDate: 'eventDate',
                        eventTime: 'eventTime',
                        eventVenue: 'eventVenue',
                        eventDescription:
                            "Hey You,We have been discussing an NFT project inside Discord and finally started building one.We did our 1st part of brainstorming on 12th July'22 (Tuesday) and we will be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finish the plan.",
                        eventImage: const Image(
                          image: NetworkImage('https://bit.ly/3IHowRx'),
                        ),
                        buttonText: 'buttonText',
                        onButtonPress: () {}),
                    const SizedBox(
                      width: 20,
                    ),
                    Event_Card(
                        eventName: "eventName",
                        eventDate: 'eventDate',
                        eventTime: 'eventTime',
                        eventVenue: 'eventVenue',
                        eventDescription:
                            "Hey You,We have been discussing an NFT project inside Discord and finally started building one.We did our 1st part of brainstorming on 12th July'22 (Tuesday) and we will be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finish the plan.",
                        eventImage: const Image(
                          image: NetworkImage('https://bit.ly/3IHowRx'),
                        ),
                        buttonText: 'buttonText',
                        onButtonPress: () {})
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<StudentCoin> levelDetails() {
    return FutureBuilder<StudentCoin>(
      future: StudentCoinHttp.getStudentCoinDetails(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data!.level}', style: kDarkTextStyle);
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text('');
        //Center(child: CircularProgressIndicator());
      },
    );
  }

  FutureBuilder<StudentCoin> sigmaCoinDetails() {
    return FutureBuilder<StudentCoin>(
      future: StudentCoinHttp.getStudentCoinDetails(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data!.sigmaCoin}',
              style: kDarkTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.bold));
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text('');
        //Center(child: CircularProgressIndicator());
      },
    );
  }

  FutureBuilder<StudentCoin> alphaCoinDetials() {
    return FutureBuilder<StudentCoin>(
      future: StudentCoinHttp.getStudentCoinDetails(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data!.alphaCoin}',
              style: kDarkTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.bold));
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text('');
        //Center(child: CircularProgressIndicator());
      },
    );
  }
}

class StudentDetailView extends StatelessWidget {
  StudentDetailView({
    Key? key,
    required this.studentDetails,
    required this.levelDetials,
    required this.sigmaCoinDetails,
    required this.alphaCoinDetials,
  }) : super(key: key);
  StudentDetails? studentDetails;
  FutureBuilder<StudentCoin> levelDetials;
  FutureBuilder<StudentCoin> sigmaCoinDetails;
  FutureBuilder<StudentCoin> alphaCoinDetials;
  @override
  Widget build(BuildContext context) {
    final String studentName =
        "${studentDetails?.first_name} ${studentDetails?.last_name}";
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: kNeutralColor,
                  radius: 60,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentName,
                      style: kDarkTextStyle,
                    ),
                    const SizedBox(height: 10),
                    XpBar(
                      xpPercent: xpPercent,
                      level: levelDetials,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: kNeutralColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/alphaCoin.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              sigmaCoinDetails,
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: kNeutralColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/sigmaCoin.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              alphaCoinDetials,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
