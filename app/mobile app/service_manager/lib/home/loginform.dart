import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_manager/main.dart';

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
      final response = await http.post(Uri.parse(server), body: {
        'email': _loginEmailController.text,
        'password': _loginPasswordController.text
      });
      if (response.statusCode == 200) {
        print('Login successful');
        print(response.body);
      } else {
        print('HTTP faild');
      }
    }
    Navigator.of(context).pushNamed(
      '/dashboard',
      arguments: 'Hello there from the first page!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _loginEmailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(100, 163, 157, 157),
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
                obscureText: true,
                controller: _loginPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(100, 163, 157, 157),
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
