import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/student_details.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;

class StudentDetailsHttp{
  static final getEndPoint="${baseUrl}api/students/";
  static Future<StudentDetails>  getStudentDetail(String studentId) async {
    final prefs = await SharedPreferences.getInstance();
    final url=Uri.parse("$getEndPoint$studentId");
    final token = prefs.get(PREFERENCE_TOKEN_ID);
    final response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
    });
    print(response.body);
    print("this the response bks");
    if (response.statusCode == 200) {
      return StudentDetails.fromMap(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
