import 'package:flutter/material.dart';
import './searchbar.dart';
import './advertisment.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SearchBar(),
        Advertisment(
          name: 'Esara Sithumal',
          description: 'This is the service description',
          serviceName: 'Programmer',
          rating: 4.5,
        ),
      ],
    );
  }
}
