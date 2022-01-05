import 'package:flutter/material.dart';
import './loginform.dart';

//this is the hompage of the app
//logins and sign up are provided here
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _handleGoogleLogin(BuildContext context) {
    print('sign in with google button pressed');
    Navigator.of(context).pushNamed(
      '/addservice',
    );
  }

  _handleSignUp(BuildContext context) {
    print('sign up button pressed');
    Navigator.of(context).pushNamed(
      '/signup',
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
          const LoginForm(),
          const Text('or'),
          Padding(
            padding: const EdgeInsets.only(left: 38, right: 38),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () => _handleGoogleLogin(context),
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
                  onPressed: () => _handleSignUp(context),
                  child: const Text('Sign Up'))
            ],
          )
        ],
      ),
    );
  }
}
