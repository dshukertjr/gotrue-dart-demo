import 'package:flutter/material.dart';
import 'package:gotrue/gotrue.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gotrue_dart_example/Screens/Welcome/welcome_screen.dart';
import 'package:gotrue_dart_example/components/alert_modal.dart';
import 'package:gotrue_dart_example/components/link_button.dart';
import 'package:gotrue_dart_example/components/rounded_input_field.dart';
import 'package:gotrue_dart_example/components/rounded_password_field.dart';
import 'package:gotrue_dart_example/constants.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  var email = '';
  var password = '';

  void _onSignUpPress(BuildContext context) async {
    final response = await gotrueClient.signUp(email, password);
    if (response.error != null) {
      alertModal.show(context,
          title: 'Sign up failed', message: response.error!.message);
      _btnController.reset();
    } else if (response.data == null && response.user == null) {
      alertModal.show(context,
          title: 'Email verification required',
          message:
              "Please check your email and follow the instructions to verify your email address.");
      _btnController.success();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(PERSIST_SESSION_KEY, response.data!.persistSessionString);
      final title = 'Welcome ${response.data!.user!.email}';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WelcomeScreen(title);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15.0),
            RoundedInputField(
              hintText: "Email address",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 15.0),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            SizedBox(height: 15.0),
            RoundedLoadingButton(
              child: Text('Sign up',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              controller: _btnController,
              onPressed: () {
                _onSignUpPress(context);
              },
            ),
            SizedBox(height: 35.0),
            LinkButton(
                text: "Already have an Account ? Sign in",
                press: () {
                  Navigator.of(context).pushReplacementNamed(SIGNIN_SCREEN);
                }),
          ],
        ),
      ),
    );
  }
}
