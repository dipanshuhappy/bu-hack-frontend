

import 'package:BUPLAY/models/transaction_detail.dart';
import 'package:BUPLAY/services/transaction_http.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _id="";
  String _coin="alpha";
  String _time_period="week";
  bool _latest=false;
  int selected =0;
  @override
  void initState() {
    print("mail ");

    SharedPreferences.getInstance().then((prefs) {
      print(prefs.getString(PREFERENCE_STUDENT_EMAIL));
      setState((){
        _id=prefs.getString(PREFERENCE_STUDENT_EMAIL)!;
      });
    });
    print(_id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Transaction History',style: kDarkTextStyle,),
        ),
        body: Center(
        child:
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // RadioListTile(
                  //   title: Text("Alpha"),
                  //   value: "alpha",
                  //   groupValue: _coin,
                  //   onChanged: (value){
                  //     setState(() {
                  //       _coin = value.toString();
                  //     });
                  //   },
                  // ),
                  // RadioListTile(
                  //   title: Text("Sigma"),
                  //   value: "sigma",
                  //   groupValue: _coin,
                  //   onChanged: (value){
                  //     print("${value} this from radiotiles");
                  //     setState(() {
                  //       _coin = value.toString();
                  //     });
                  //   },
                  // ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: CustomRadioButton("sigma", 0)),
                      const SizedBox(width: 10,),
                      Expanded(child: CustomRadioButton("alpha", 1)),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  Expanded(child: TransactionList(id: _id,coin: _coin,time_period: _time_period,userType: "receiver_id",)),

                ],
              ),
            )
    )
    // Column(
      // children: [
      //   Row(
      //     children: [
      //       RadioListTile(
      //         title: Text("Alpha"),
      //         value: "alpha",
      //         groupValue: _coin,
      //         onChanged: (value){
      //           setState(() {
      //             _coin = value.toString();
      //           });
      //         },
      //       ),
      //       RadioListTile(
      //         title: Text("Sigma"),
      //         value: "sigma",
      //         groupValue: _coin,
      //         onChanged: (value){
      //           setState(() {
      //             _coin = value.toString();
      //           });
      //         },
      //       )
      //     ],
      //   ),
      // // Row(
      // //   children: [
      // //     RadioListTile(
      // //       title: Text("Week"),
      // //       value: "week",
      // //       onChanged: (value){
      // //         setState((){
      // //           _time_period=value.toString();
      // //         }
      // //         );
      // //       }, groupValue: _time_period,
      // //     ),
      // //     RadioListTile(
      // //       title: Text("Month"),
      // //       value: "month",
      // //       onChanged: (value){
      // //         setState((){
      // //           _time_period=value.toString();
      // //         }
      // //         );
      // //       }, groupValue: _time_period,
      // //     )
      // //   ],
      // TransactionList(id: _id,coin: _coin,time_period: _time_period)
    );
  }

  Widget CustomRadioButton(String text,int index){
    return OutlinedButton(
      onPressed: (){
        setState(() {
          selected = index;
          _coin=text;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: selected == index ? kAccentColor : Colors.deepPurple.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text,style: TextStyle(color: selected == index ? primaryColor : kDarkColor,fontWeight: FontWeight.w700),),
    );
  }
}
class TransactionList extends StatelessWidget {
  String id;
  String coin="alpha";
  String time_period="";
  String userType="receiver_id";
  TransactionList({Key? key,required this.id,required this.time_period,required this.coin,required this.userType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionDetail>>(
      future: TransactionHttp.getTransactionHistory(id,type: coin,timePeriod: time_period,latest: true,user: userType),
        builder: (context,snapshot){
            if(snapshot.data==null){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              print("${snapshot.error.toString()}  this is transacction errorrrrrrrrrrrrrrrrrrrr");
              return Text("Error");
            }
            List<TransactionDetail> transactions=snapshot.data!;
            return ListView.builder(
              itemCount: snapshot.data?.length,
                itemBuilder:(context,index){
                    TransactionDetail transactionDetail=transactions[index];
                      return ReceiveTransactionItem(

                          id: transactionDetail.id,
                          userType:userType,
                          senderId: transactionDetail.senderId,
                          amount: transactionDetail.amount,
                          dateTime: transactionDetail.currentTimestamp,
                          receiverId:transactionDetail.receiverId
                      );

                }
            );
        }
    );
  }
}
class ReceiveTransactionItem extends StatelessWidget {
  int id;
  String senderId;
  int amount;
  String dateTime;
  String userType;
  String receiverId;
   ReceiveTransactionItem(
      {
        Key? key,
        required this.id,
        required this.userType,
        required this.senderId,
        required this.amount,
        required this.dateTime,
        required this.receiverId
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getDateStringInFormat(String date){
      DateTime dateTime=DateTime.parse(date);
      return "${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute}";
    }
    List<Widget> getTransactionCard(){
      if(userType=="receiver_id"){
        return [
          Text('''Received $amount from''',
            style: kLightTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),
          const SizedBox(height: 5,),
          Text('''$senderId''',
            style: kLightTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),
          const SizedBox(height: 5,),
          Text("At ${getDateStringInFormat(dateTime)} with id $id",style: kLightTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w300),),
        ];
      }
      return  [
        Text('''Sent  $amount to''',
          style: kLightTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),
        const SizedBox(height: 5,),
        Text('''$receiverId''',
          style: kLightTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),
        const SizedBox(height: 5,),
        Text("At ${getDateStringInFormat(dateTime)} with id $id",style: kLightTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w300),),
      ];

    }
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: kDarkSecondaryColor,
      ),
      child: Row(
        children: [

          Icon(Icons.payment,color: primaryColor,),
          const SizedBox(width: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:getTransactionCard(),
          ),
          const SizedBox(width: 20),

        ],
      ),
    );
  }
}




