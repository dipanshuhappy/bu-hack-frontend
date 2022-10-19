import 'package:BUPLAY/Screens/admin/AdminFunctions.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/Button.dart';
import 'package:BUPLAY/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}



class _AdminScreenState extends AdminFunctions {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:[
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 20, left: 20),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text(
                    'Admin Dashboard',
                    style: kDarkTextStyle
                    ),
                   const SizedBox(height: 10),
                  Text(
                    'Welcome back, Admin',
                    style: kDarkTextStyle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Here You can add new users, edit users, and delete users /n  and you can add coins to the user profile',
                    style: kDarkTextStyle.copyWith(
                      fontSize:18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Aplha Coins Based on Quiz results',style: kLightTextStyle,),
                const SizedBox(height: 20),
                BasicButton(onPress: ()=> addNewDialog(context), buttonText: 'Add Coins via Excel')
              ],
            )
          ]
        )
      ),

    );
  }

}
