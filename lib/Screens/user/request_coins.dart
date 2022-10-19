import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/Button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../utils/Widgets/test_feild_input.dart';
import '../../utils/colors.dart';

class RequestCoins extends StatefulWidget {
  const RequestCoins({Key? key}) : super(key: key);

  @override
  State<RequestCoins> createState() => _RequestCoinsState();
}

class _RequestCoinsState extends State<RequestCoins> {
  int selected = 0;
  String _text = "Academic";
  var excelPicked = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Coins',
          style: kDarkTextStyle,
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kDarkPrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is it related to?',
                style: kLightTextStyle,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: CustomRadioButton("Academic", 0)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: CustomRadioButton("Non-Academic", 1)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFieldInput(
                  textEditingController: TextEditingController(),
                  hintText: '  Enter your request',
                  textInputType: TextInputType.text,
                  expand: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Do you wanna attach any file?',
                style: kLightTextStyle.copyWith(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              BasicButtonWithIcon(
                onPress: () async {
                  final excelPicker = await FilePicker.platform.pickFiles();
                  if (excelPicker == null) return;
                  excelPicked = excelPicker.files.first;
                },
                buttonText: 'Select',
                vPadding: 12,
                hPadding: 16,
                width: MediaQuery.of(context).size.width * 0.4,
                icon: const Icon(
                  Icons.upload_file,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'File Name: ${excelPicked == null ? 'No File Chosen' : excelPicked.name}',
                style: kDarkTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Flexible(flex: 1,child: Container(),),
              BasicButton(
                buttonText: 'Submit',
                onPress: () {},
                vPadding: 12,
                hPadding: 20,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
          _text = text;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor:
            selected == index ? kAccentColor : Colors.deepPurple.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: selected == index ? primaryColor : kDarkColor,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
