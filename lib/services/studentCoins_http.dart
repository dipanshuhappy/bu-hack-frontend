import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:BUPLAY/models/studentCoin_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/student_details.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;

class StudentCoinHttp{

  static final getEndPoint="${baseUrl}api/studentsCoin/";
  static Future<StudentCoin>  getStudentCoinDetails(String studentId) async {
    final prefs = await SharedPreferences.getInstance();
    final url=Uri.parse("$getEndPoint$studentId");
    final token = prefs.get(PREFERENCE_TOKEN_ID);
    final response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
    });
    log(response.body);
    print("this the response");
    if (response.statusCode == 200) {
      return StudentCoin.fromMap(jsonDecode(response.body));
    } else {
      log(response.body);
      throw Exception(response.body);

    }
  }
}