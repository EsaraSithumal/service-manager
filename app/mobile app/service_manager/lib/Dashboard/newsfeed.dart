import 'package:flutter/material.dart';
import './advertisment.dart';

class NewsFeed extends StatelessWidget {
  //this object contains all the advertisment data received from the parent: dashboard
  final Set<Map<String, Object>> advertisments;
  const NewsFeed({required this.advertisments, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //map each advertisment data to advertisment widget to render
          ...advertisments.map(
            (advertisment) {
              return Advertisment(
                name: advertisment['name'].toString(),
                description: advertisment['description'].toString(),
                serviceName: advertisment['sName'].toString(),
                rating: double.parse(advertisment['rating'].toString()),
                pimageURL: advertisment['profilePhoto'].toString(),
                addID: advertisment['id'].toString(),
                image: advertisment['imageURL'].toString(),
              );
            },
          ),
        ],
      ),
    );
  }
}

/*child: Column(
        children: const [
          Advertisment(
            name: 'Esara Sithumal',
            description: 'This is the service description',
            serviceName: 'Programmer',
            rating: 4.5,
            imageURL: '',
            addID: '1',
          ),
          Advertisment(
            name: 'Pubudu Bandara',
            description: 'This is the service description',
            serviceName: 'Web Developer',
            rating: 4,
            imageURL: '',
            addID: '2',
          ),
          Advertisment(
            name: 'Achintha Harshamal',
            description: 'This is the service description',
            serviceName: 'Full Stack Developer',
            rating: 4.5,
            imageURL: '',
            addID: '3',
          ),
          Advertisment(
            name: 'Hansa Alahacoon',
            description: 'This is the service description',
            serviceName: 'Embedded System Engineer',
            rating: 3.0,
            imageURL: '',
            addID: '4',
          ),
        ],
      ),*/