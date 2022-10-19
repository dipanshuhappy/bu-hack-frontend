import 'package:BUPLAY/Screens/Professor/professorDashboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../utils/Styles.dart';
import '../../utils/Widgets/Button.dart';
import '../../utils/colors.dart';


abstract class ProfessorFunctions extends State<ProfessorDashboard> {
  var excelPicked = null;
  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: primaryColor,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              const Text('Add Excel Sheet',style: kDarkTextStyle,),
              const SizedBox(height: 10,),
              BasicButton(onPress: () async {
                final excelPicker = await FilePicker.platform.pickFiles();
                if(excelPicker == null) return;
                excelPicked = excelPicker.files.first;
              },
                  buttonText: 'choose file'),
              const SizedBox(height: 10,),
              Text(
                'File Name: ${excelPicked == null ? 'No File Chosen' : excelPicked.name}',
                style: kDarkTextStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
        actions: <Widget>[
          BasicButton(onPress: Navigator.of(context).pop, buttonText: 'Cancel'),
          BasicButton(onPress: (){}, buttonText: 'Proceed'),
        ],
      ),
    );
  }

}
