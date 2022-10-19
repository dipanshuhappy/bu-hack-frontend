import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:BUPLAY/models/staffCoin_details.dart';
import 'package:BUPLAY/models/studentCoin_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/student_details.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;

class StaffCoinHttp{

  static final getEndPoint="${baseUrl}api/staffCoin/";
  static Future<StaffCoin>  getStaffCoinDetails(String staffId) async {
    final prefs = await SharedPreferences.getInstance();
    final url=Uri.parse("$getEndPoint$staffId");
    final token = prefs.get(PREFERENCE_TOKEN_ID);
    final response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
    });
    log(response.body);
    print("this is staff coin");
    print("staff coin is response is");
    print(response.body);
    if (response.statusCode == 200) {
      return StaffCoin.fromMap(jsonDecode(response.body));
    } else {
      log(response.body);
      throw Exception(response.body);
    }
  }

}