import 'package:flutter/material.dart';
import './advertisment.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Advertisment(
            name: 'Esara Sithumal',
            description: 'This is the service description',
            serviceName: 'Programmer',
            rating: 4.5,
          ),
          Advertisment(
            name: 'Pubudu Bandara',
            description: 'This is the service description',
            serviceName: 'Web Developer',
            rating: 4,
          ),
          Advertisment(
            name: 'Achintha Harshamal',
            description: 'This is the service description',
            serviceName: 'Full Stack Developer',
            rating: 4.5,
          ),
          Advertisment(
            name: 'Hansa Alahacoon',
            description: 'This is the service description',
            serviceName: 'Embedded System Engineer',
            rating: 3.0,
          ),
        ],
      ),
    );
  }
}
