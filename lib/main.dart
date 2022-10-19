import 'package:BUPLAY/Screens/auth/login_screen.dart';
import 'package:BUPLAY/Screens/auth/signup_screen.dart';
import 'package:BUPLAY/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sample',
        theme: ThemeData.dark().copyWith(

      scaffoldBackgroundColor: kDarkPrimaryColor,
          primaryColor: Colors.deepPurple.shade100,
    ),
    home: //MobileScreenLayout()
      //ProfessorDashboard()
       //MentorDashboard()
      SignUpScreen()
    );
  }
}

