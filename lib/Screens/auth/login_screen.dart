import 'dart:developer';

import 'package:BUPLAY/Screens/Professor/professorDashboard.dart';
import 'package:BUPLAY/Screens/auth/signup_screen.dart';
import 'package:BUPLAY/responsive/mobile_screen_layout.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:BUPLAY/utils/colors.dart';
import 'package:BUPLAY/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _userType="student";
  @override
  Widget build(BuildContext context) {
    void _gotoHomeScreen(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => (const MobileScreenLayout())));
    }
    void _gotoProfessorDashboard(){
      Navigator.push(context,
            MaterialPageRoute(builder: (context) => (const ProfessorDashboard())));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',style: kDarkTextStyle,),
        backgroundColor: primaryColor,
      ),
      body:Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Login Page',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),

              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
          RadioListTile(
              title: Text("Student"),
              value: "student",
              groupValue: _userType,
              onChanged: (value){
                setState(() {
                  _userType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Staff"),
              value: "staff",
              groupValue: _userType,
              onChanged: (value){
                setState(() {
                  _userType = value.toString();
                });
              },
            ),

              Container(
                  height: 50,
                  width: 20,
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      try{
                        print(_userType);
                        if(_userType=="student"){
                          final credentials= await StudentAuthHttp.loginStudent(nameController.text, passwordController.text);
                          prefs.setString(PREFERENCE_STUDENT_EMAIL,nameController.text+"@bennett.edu.in");
                          prefs.setString(PREFERENCE_TOKEN_ID,credentials.token);
                          _gotoHomeScreen();
                        }
                        else{
                          final credentials = await StudentAuthHttp.loginStaff(nameController.text, passwordController.text);
                          prefs.setString(PREFERENCE_PROFESSOR_EMAIL,nameController.text+"@bennett.edu.in");
                          prefs.setString(PREFERENCE_TOKEN_ID,credentials.token);
                          _gotoProfessorDashboard();
                        }
                      }
                      catch (e){
                          log("$e");
                      }
                    },
                  ),
              ),
              Container(
                height: 200,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
                child:  Text(
                  'Create an account',
                  style: kLightTextStyle,
                 textAlign: TextAlign.center,
                ),
              )
            ],
          ),
      ),
    );
  }
}