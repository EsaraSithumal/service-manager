import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart'; //for the avatar in header

class SideMenuHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageURL;
  const SideMenuHeader({
    Key? key,
    required this.name,
    required this.imageURL,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProfileAvatar(
          imageURL,
          radius: 30,
        ),
        Expanded(
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            email,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
