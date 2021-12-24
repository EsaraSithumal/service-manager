import 'package:flutter/material.dart';
import './loginform.dart';

//this is the hompage of the app
//logins and sign up are provided here
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  handleLogin(BuildContext context) {
    print('sign in button pressed');
    Navigator.of(context).pushNamed(
      '/dashboard',
      arguments: 'Hello there from the first page!',
    );
  }

  handleGoogleLogin(BuildContext context) {
    print('sign in with google button pressed');
    Navigator.of(context).pushNamed(
      '/dashboard',
      arguments: 'Hello there from the first page!',
    );
  }

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
          LoginForm(
            handlelogin: () => handleLogin(context),
          ),
          const Text('or'),
          Padding(
            padding: const EdgeInsets.only(left: 38, right: 38),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => handleGoogleLogin(context),
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
