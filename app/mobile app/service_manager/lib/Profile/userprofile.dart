import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:http/http.dart' as http;

import 'package:service_manager/main.dart';
import './inforow.dart';

/*
todo:
  -handle fetch data from the server
    -now displays static data
  -create futureBuilder
  -edit button tap
  -show the location on a map
*/

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final name = 'John Doe';

  final email = 'johndoe@abc.com';

  final profilePicUrl =
      'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4';

  final Map<String, String> info = const {
    'Phone Number': '+94 771 234 567',
    'Address': 'No06, Gampola Road, Peradeniya.',
    'Date Of Birth': '04/04/1995',
    'Location': '#TODO',
  };

  late Future<dynamic> _data; //for data fetched from the server

  //function to request profile data
  Future<dynamic> _fetchData() async {
    //read the access token from the secure storage
    final aToken = await secureStorage.read(key: 'accessToken');

    final http.Response response = await http.get(
      Uri.parse(server + 'home/profile'),
      headers: {'x-auth-token': aToken.toString()},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      throw Exception('Server Error');
    } else if (response.statusCode == 401) {
      throw Exception('Token Invalid');
    } else {
      throw Exception('Unknown error');
    }
  }

  //call fetchData method to get profile data from the server
  @override
  void initState() {
    super.initState();
    _data = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildProfilePage();
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Data Fetching Faild: ${snapshot.error}'),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildProfilePage() {
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
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Color.fromARGB(50, 0, 0, 0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      ...info.keys.map(
                        (key) {
                          return InfoRow(
                            label: key,
                            data: info[key].toString(),
                          );
                        },
                      ),
                    ],
                  ),
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
