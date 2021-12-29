import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_manager/main.dart';
import 'dart:convert';

//login form for email password login
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _loginEmailController = TextEditingController(); //controller for email
  final _loginPasswordController = TextEditingController(); //controller for pw

  @override
  void dispose() {
    _loginEmailController.dispose(); //cleanup email field
    _loginPasswordController.dispose(); //cleanup password field
    super.dispose();
  }

  handleLogin(BuildContext context) async {
    print('sign in button pressed');

    if (_formKey.currentState!.validate()) {
      //if data valid navigate to dashboard
      //send request to serveer

      final response = await http.post(
        Uri.parse(server + 'auth/signin'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': _loginEmailController.text,
          'password': _loginPasswordController.text
        }),
      );
      if (response.statusCode == 200) {
        print('Login successful');

        final decodedRes = jsonDecode(response.body);

        secureStorage.write(
            key: 'refreshToken', value: decodedRes['refreshToken']);
        secureStorage.write(
            key: 'accessToken', value: decodedRes['accessToken']);
        Navigator.of(context).pushNamed(
          '/dashboard',
          arguments: 'Hello there from the first page!',
        );
      } else if (response.statusCode == 401) {
        print('Authentication failed');
      } else {
        print('HTTP faild');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 42, left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _loginEmailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: TextFormField(
                //obscureText: true, //this makes text field invisible
                controller: _loginPasswordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => print('Forgot password button pressed'),
                  child: const Text('forgot password?')),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    primary: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => handleLogin(context),
                  child: const Text('Sign In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
