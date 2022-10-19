import 'package:BUPLAY/Screens/user/EditProfile.dart';
import 'package:BUPLAY/Screens/user/profileFunctions.dart';
import 'package:BUPLAY/models/studentCoin_details.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:BUPLAY/utils/XP_bar.dart';
import 'package:BUPLAY/utils/colors.dart';
import 'package:BUPLAY/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/student_details.dart';
import '../../services/studentCoins_http.dart';
import '../../services/students_http.dart';
import '../../utils/Styles.dart';
import '../../utils/global_variables.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

int xpPercent = 50;

showDialogBox2(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()));
              });
            },
            child: const Text('Edit Profile'),
          ),
        ],
      );
    },
  );
}

class _ProfilePageState extends ProfileFunctions {
  String _studentId = "";

  // getData() async {
  //  <StudentDetails> userSnap = await StudentsHttpService.getStudentById(_studentId);
  // }
  initState() {
    print("this is  in init state from profile page");
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 400,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: kAccentColor,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.58,
                        ),
                        IconButton(
                          onPressed: () => showDialogBox2(context),
                          icon: Icon(
                            Icons.more_vert,
                            color: kAccentColor,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: kAccentColor,
                    ),
                    studentNameDetails(),
                    XpBar(
                      xpPercent: xpPercent,
                      level: levelDetails(),
                      barWidth: MediaQuery.of(context).size.width * 0.7,
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
                              sigmaCoinDetails(),
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
                              alphaCoinDetials(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'User Information',
                          style: kLightTextStyle.copyWith(fontSize: 25),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        loader(),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FieldBox(
                      label: 'Name:',
                      value: studentFullNameDetails(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FieldBox(label: 'Enroll:', value: studentEnrollDetails()),
                    const SizedBox(
                      height: 10,
                    ),
                    FieldBox(
                        label: 'Semester:', value: studentSemesterDetails()),
                    const SizedBox(
                      height: 10,
                    ),
                    FieldBox(label: 'Group:', value: studentGroupDetails()),
                    const SizedBox(
                      height: 10,
                    ),
                    FieldBox(label: 'Batch:', value: studentBatchDetails()),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<StudentDetails> studentNameDetails() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.first_name + " " + snapshot.data!.last_name,
            style: kDarkTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.normal),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text(' ');
      },
    );
  }

  FutureBuilder<StudentDetails> studentFullNameDetails() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.first_name + " " + snapshot.data!.last_name,
            style: kLightTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.w600),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text(' ');
      },
    );
  }

  FutureBuilder<StudentDetails> studentEnrollDetails() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.enrollment_number,
            style: kLightTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.w600),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text(' ');
      },
    );
  }

  FutureBuilder<StudentDetails> studentSemesterDetails() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.current_semester,
            style: kLightTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.w600),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text(' ');
      },
    );
  }

  FutureBuilder<StudentDetails> studentBatchDetails() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.batch,
            style: kLightTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.w600),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return Text(' ');
      },
    );
  }

  FutureBuilder<StudentDetails> studentGroupDetails() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int group = 0;
          int groupId = 0;
          String batch = snapshot.data!.batch;
          for (int i = 0; i < batches.length; i++) {
            if (batches[i] == batch) {
              groupId = i;
              if (groupId >= 5 && groupId <= 10) {
                group = 1;
              }
              if (groupId >= 11 && groupId <= 15) {
                group = 2;
              }
              if (groupId >= 16 && groupId <= 20) {
                group = 3;
              }
              if (groupId >= 21 && groupId <= 25) {
                group = 4;
              }
              if (groupId >= 26 && groupId <= 30) {
                group = 5;
              }
            } else {
              continue;
            }
          }

          return Text(
            '$group',
            style: kLightTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.w600),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return showSnackBar(context, snapshot.error.toString());
        }
        return Text(' ');
      },
    );
  }

  FutureBuilder<StudentDetails> loader() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(_studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Text(" ");
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(snapshot.error.toString());
        }
        return const CircularProgressIndicator();
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
}

class FieldBox extends StatelessWidget {
  final String label;
  FutureBuilder<StudentDetails> value;
  FieldBox({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: kDarkSecondaryColor,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: kLightTextStyle,
          ),
          const SizedBox(width: 20),
          value,
        ],
      ),
    );
  }
}
