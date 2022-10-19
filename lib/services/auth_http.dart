import 'dart:convert';

import 'package:BUPLAY/models/staff_auth.dart';

import '../models/student_auth.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;
class StudentAuthHttp{
  static final postEndPoint="${baseUrl}api/auth/";
  static Future<StudentAuth> loginStudent(String username,String password) async{
    final url = Uri.parse(postEndPoint);
    final response = await http.post(url,  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(<String, String>{
          'username': username,
          'password':password,
          'type':"student"
        })
    );
    if (response.statusCode == 200) {
      return StudentAuth.fromMap(jsonDecode(response.body));
    } else {
      print(response.toString());
      print(response.body);
      throw Exception("${response.statusCode}");
    }
  }
  static Future<StaffAuth> loginStaff(String username,String password) async{
    final url = Uri.parse(postEndPoint);
    final response = await http.post(url,  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(<String, String>{
          'username': username,
          'password':password,
          'type':"staff"
        })
    );
    if (response.statusCode == 200) {
      return StaffAuth.fromMap(jsonDecode(response.body));
    } else {
      print(response.toString());
      print(response.body);
      throw Exception("${response.statusCode}");
    }
  }

}
