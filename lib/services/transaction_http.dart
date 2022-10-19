import 'dart:convert';
import 'dart:io';

import 'package:BUPLAY/Screens/user/transaction_history_screen.dart';
import 'package:BUPLAY/models/transaction_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/student_details.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;

class TransactionHttp{
  static const getEndPoint="${baseUrl}api/students/";
  static Future<List<TransactionDetail>>  getTransactionHistory(String id,{String user="receiver_id",String type="alpha",bool latest=true,String timePeriod="week"}) async {
    final prefs = await SharedPreferences.getInstance();
    var url=Uri.parse("${baseUrl}api/transaction/$type/").replace(
      queryParameters: {
        user:id.toString(),
        'latest':latest?"true":"false",

        "time_period":timePeriod,
      }
    );
    final token = prefs.get(PREFERENCE_TOKEN_ID);
    final response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
    });
    if (response.statusCode == 200) {
      var jsonData=jsonDecode(response.body);
      List<TransactionDetail> transactionsHistory=[];
      for(var jsonTransaction in jsonData){
        print("Json transaction $jsonTransaction");
          transactionsHistory.add(
              TransactionDetail.fromMap(
                  jsonTransaction
              )
          );
        print("array ${transactionsHistory.toString()}");
      }
      print("array ${transactionsHistory.toString()}");
      return transactionsHistory;
    } else {
      throw Exception(response.body);
    }
  }
  static Future<TransactionDetail> makeSigmaTransaction(String senderId,String receiverId,int amount) async {
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
      "receiver_id":receiverId,
      "amount":amount.toString(),
    });
    print("$encode this is the encode ddd");
    var response = await http.post(url,headers: {
      // 'Content-Type': 'application/text; charset=UTF-8',
      // HttpHeaders.contentTypeHeader:"application/json",
      HttpHeaders.authorizationHeader: 'Token $token',
    },
      body:<String,String>{
        "sender_id":senderId,
        "receiver_id":receiverId,
        "amount":amount.toString(),
      }
    );
    print("url");
    if (response.statusCode == 200){
      print("this is responsesss transactionnnn  ${response.body}");
      return TransactionDetail.fromMap(jsonDecode(response.body));
    }
    else {
      throw Exception(response.body);
    }
  }
}