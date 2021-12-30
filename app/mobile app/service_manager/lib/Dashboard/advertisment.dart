import 'package:flutter/material.dart';
import './advertismentdata.dart';

//this widget is for render a one advertisment
class Advertisment extends StatelessWidget {
  final String name; //for name of the service provider
  final String description; //description of the add
  final String serviceName; //service name
  final String pimageURL; //URL of profile photo of the service provider
  final double rating; //rating of the service
  final String addID; //ID of the service
  final String image; //URL of the advertisment image

  const Advertisment({
    required this.name,
    required this.description,
    required this.serviceName,
    required this.rating,
    required this.pimageURL,
    required this.image,
    required this.addID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          //this is the top section of the add
          Container(
            width: double.infinity,
            height: 200,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            child: FittedBox(
              child: Image.network(image),
              fit: BoxFit.fill,
            ),
          ),
          //this is the bottom section of the add which contains data
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: AddData(
              description: description,
              name: name,
              serviceName: serviceName,
              rating: rating,
              pimageURL: pimageURL,
            ),
          ),
        ],
      ),
    );
  }
}
