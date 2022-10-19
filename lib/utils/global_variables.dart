import 'package:BUPLAY/Screens/user/Home.dart';
import 'package:BUPLAY/Screens/user/Profile_Screen.dart';
import 'package:BUPLAY/Screens/user/leaderboardScreen.dart';
import 'package:BUPLAY/Screens/user/transaction_history_screen.dart';
import 'package:flutter/material.dart';

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const TransactionHistoryScreen(),
  const ProfilePage(),
];
const String baseUrl="https://bu-play-backend.herokuapp.com/";
//String currentUserId = FirebaseAuth.instance.currentUser!.uid;
String currentUserName = 'User';
String currentEnrollment = 'E21CSEU0246';
String currentName = 'Swaraj Bachu';
String Batch = 'E21';
String currentGroup = 'G2';
String currentSemester = 'S2';

const String PREFERENCE_TOKEN_ID="token";
const String PREFERENCE_STUDENT_EMAIL="student_id";
const String PREFERENCE_PROFESSOR_EMAIL="professor_id";

List<String> groups = ['G1','G2','G3','G4','G5'];

List<String> batches = ['eb1','eb2','eb3','eb4','eb5','eb6','eb7','eb8','eb9','eb10','eb11','eb12','eb13'
,'eb14','eb15','eb16','eb17','eb18','eb19','eb20','eb21','eb22','eb23','eb24','eb25','eb26','eb27','eb28','eb29','eb30'];

List<String> semester = ['I','II','III','IV','V','VI','VII','VIII'];