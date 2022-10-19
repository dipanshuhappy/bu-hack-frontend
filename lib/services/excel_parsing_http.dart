import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/alpha_excel_parsing_detials.dart';
import '../models/student_details.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;

class excelParsingHttp{
  static const getEndPoint="${baseUrl}api/students/";

  static Future<AlphaExcelParsingDetails> makeAlphaExcelParsing(String senderId,String quizTimings,String quizSubject,var excelPicked) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get(PREFERENCE_TOKEN_ID);
    print("this is the tokennnnnnn $token");
    Uri url= Uri.parse("${baseUrl}api/transaction/sigma/make-transaction");
    // var body =<String,String>{
    //   "sender_id":senderId,
    //   "receiver_id":receiverId,
    //   "amount":amount.toString(),
    // };
    // print("${body} this the bodyyyyyy");
    var encode =jsonEncode(<String,String>{
      "sender_id":senderId,
      "quiz_time":quizTimings,
      "quiz_subject":quizSubject,
      "excel_picked":excelPicked,
    });
    print("$encode this is the encode ddd");
    var response = await http.post(url,headers: {
      // 'Content-Type': 'application/text; charset=UTF-8',
      // HttpHeaders.contentTypeHeader:"application/json",
      HttpHeaders.authorizationHeader: 'Token $token',
    },
        body:<String,String>{
          "sender_id":senderId,
          "quiz_time":quizTimings,
          "quiz_subject":quizSubject,
          "excel_picked":excelPicked,
        }
    );
    print("url");
    if (response.statusCode == 200){
      print("this is responsesss parsing  ${response.body}");
      return AlphaExcelParsingDetails.fromMap(jsonDecode(response.body));
    }
    else {
      throw Exception(response.body);
    }
  }
}