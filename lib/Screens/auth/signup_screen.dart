import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Styles.dart';
import '../../utils/Widgets/test_feild_input.dart';
import '../../utils/colors.dart';
import 'login_screen.dart';





class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {


  final bool _isLoading = false;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _LastnameController = TextEditingController();
  final TextEditingController _EnrollController = TextEditingController();
  final TextEditingController _BatchController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Sign Up',
          style: kDarkTextStyle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Flexible(child: Container(),flex: 1,),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'First Name',
              textEditingController: _firstnameController,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Last Name',
              textEditingController: _LastnameController,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Enrollment Number',
              textEditingController: _EnrollController,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Batch',
              textEditingController: _BatchController,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Course',
              textEditingController: _courseController,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Email',
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInputPass(
              hintText: 'password',
              textEditingController: _passwordController,
              textInputType: TextInputType.text,
              isPass: true,
            ),
             const SizedBox(height: 20,),

             ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign Up'),
                  ),
            Flexible(child: Container(),flex: 1,),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


