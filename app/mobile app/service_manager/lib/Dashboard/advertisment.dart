import 'package:flutter/material.dart';
import './advertismentdata.dart';

class Advertisment extends StatelessWidget {
  final String name;
  final String description;
  final String serviceName;
  final double rating;

  const Advertisment({
    required this.name,
    required this.description,
    required this.serviceName,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(color: Colors.brown[200]),
            child: Text('Image'),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.brown[500]),
            child: AddData(
              description: this.description,
              name: this.name,
              serviceName: this.serviceName,
              rating: this.rating,
            ),
          ),
        ],
      ),
    );
  }
}
