import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

/*
todo:
  -fetech data from the server
    -now displays static data
  -create futureBuilder
  -edit button tap
*/

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  final name = 'John Doe';
  final email = 'johndoe@abc.com';
  final profilePicUrl =
      'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4';
  final address = 'No 111,Kandy road,Peradeniya';
  final DOB = '04-04-1999';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  CircularProfileAvatar(
                    profilePicUrl,
                    radius: 75,
                    borderWidth: 5,
                    borderColor: Theme.of(context).colorScheme.primary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      email,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text('Address : $address'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text('Date Of Birth : $DOB'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
