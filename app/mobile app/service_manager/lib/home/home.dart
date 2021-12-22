import 'package:flutter/material.dart';

//this is the hompage of the app
//logins and sign up are provided here
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Service Manager',
            style: TextStyle(fontSize: 50, color: Colors.black87),
          ),
          const LoginForm(),
          const Text('or'),
          Padding(
            padding: const EdgeInsets.only(left: 38, right: 38),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => print('sign in with google button pressed'),
                child: const Text('Login With Google'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Don\'t Have an Account?'),
              TextButton(
                  onPressed: () => print('Sign Up button pressed'),
                  child: const Text('Sign Up'))
            ],
          )
        ],
      ),
    );
  }
}

//login form for email password login
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

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
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
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
            Padding(
              padding: const EdgeInsets.only(
                left: 200.0,
              ),
              child: TextButton(
                  onPressed: () => print('Forgot password button pressed'),
                  child: const Text('forgot password?')),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ElevatedButton(
                  onPressed: () => print('sign in button pressed'),
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
