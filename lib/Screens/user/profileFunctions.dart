import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:BUPLAY/models/studentCoin_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/student_details.dart';
import '../../services/studentCoins_http.dart';
import '../../services/students_http.dart';
import '../../utils/Styles.dart';
import '../../utils/global_variables.dart';
import 'Profile_Screen.dart';
import 'package:http/http.dart' as http;

abstract class ProfileFunctions extends State<ProfilePage> {

  static final getEndPoint="${baseUrl}api/students/";

  String _studentId = "";

  initState() {
    SharedPreferences.getInstance().then((prefs) {
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

  String fullName = "";

    profileDetails(String name, String enrollment,
      String batch, String semester) {
    setState(() {
      fullName = name;
      currentEnrollment = enrollment;
      Batch = batch;
      currentSemester = semester;
    });
    log('${name}'+'${enrollment}'+'${batch}'+'${semester}');
  }

    getStudentsDetails() {
    return FutureBuilder<StudentDetails>(
      future: StudentDetailsHttp.getStudentDetail(
          _studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("this is the snapshot data");
          return profileDetails('${snapshot.data!.first_name}'+" "+'${snapshot.data!.last_name}', "${snapshot.data!.enrollment_number}", "${snapshot.data!.batch}",  "${snapshot.data!.current_semester}");
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

