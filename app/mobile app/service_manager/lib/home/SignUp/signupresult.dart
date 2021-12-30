import 'package:flutter/material.dart';

class SignUpResult extends StatelessWidget {
  final Future<bool>? isSucceed;
  const SignUpResult({Key? key, required this.isSucceed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isSucceed,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Center(
            child: Text('Signup Succeed.'),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Signup failed try again.'),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    ;
  }
}
