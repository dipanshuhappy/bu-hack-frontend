import 'dart:typed_data';

import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/Button.dart';
import 'package:BUPLAY/utils/global_variables.dart';
import 'package:BUPLAY/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Uint8List? _image;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  int groupIndex = 0;
  int semesterIndex = 0;
  int batchIndex = 0;

  @override
  void initState(){
    super.initState();
    _usernameController.text = currentUserName;
    //nameEditingController.text = GlobalVariables.user.name;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save_alt_rounded,
              color: kDarkPrimaryColor,
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kDarkPrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          'Edit Profile',
          style: kDarkTextStyle.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                              backgroundColor: Colors.red,
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'),
                              backgroundColor: Colors.red,
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        currentName,
                        style: kLightTextStyle.copyWith(
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          onPressed:()=> addNewDialog(context), icon: const Icon(Icons.edit)),
                    ],
                  ),
                  Text(
                    currentEnrollment,
                    style:
                        kLightTextStyle.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _usernameController,
              style: kLightTextStyle,
              decoration: InputDecoration(
                labelText: 'Your Username',
                labelStyle: kLightTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return showSnackBar(context, "Username Can't be empty");
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            EditFieldBox(
              label: 'Group',
              value: groups[groupIndex],
              cupertino: buildPicker(groups),
            ),
            const SizedBox(height: 20),
            EditFieldBox(
              label: 'Semester',
              value: semester[semesterIndex],
              cupertino: buildPicker(semester),
            ),
            const SizedBox(height: 20),
            EditFieldBox(
              label: 'Batch',
              value: batches[batchIndex],
              cupertino: buildPicker(batches),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPicker(List listName) {
    return SizedBox(
      height: 150,
      child: CupertinoPicker(
        itemExtent: 50,
        magnification: 1,
        onSelectedItemChanged: (index) {
          setState(() {
            if (listName == groups) {
              groupIndex = index;
            } else if (listName == semester) {
              semesterIndex = index;
            } else if (listName == batches) {
              batchIndex = index;
            }
          }
          );

        },
        children: listName
            .map((item) => Center(
                  child: Text(
                    item,
                    style: kLightTextStyle,
                  ),
                ))
            .toList(),
      ),
    );
  }

  addNewDialog(context) {
     showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade100,
        content: TextField(
          controller: nameEditingController,
          maxLines: 1,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              fillColor: kDarkSecondaryColor,
              filled: true,
              hintText: 'Your Name'),
        ),
        actions: <Widget>[
          BasicButton(onPress: () => Navigator.of(context).pop(), buttonText: 'Cancel'),
          BasicButton(onPress: (){
            setState(() {
              currentName = nameEditingController.text;
            });
            Navigator.of(context).pop();
          }, buttonText: 'Save'),

        ],
      ),
    );
  }
}

class EditFieldBox extends StatelessWidget {
  final String label;
  final String value;
  final Widget cupertino;
  const EditFieldBox({
    Key? key,
    required this.label,
    required this.value,
    required this.cupertino,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: kDarkSecondaryColor,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: kLightTextStyle,
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: kLightTextStyle,
          ),
          IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                          actions: [cupertino],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ));
              },
              icon: Icon(Icons.edit)),
        ],
      ),
    );
  }
}
