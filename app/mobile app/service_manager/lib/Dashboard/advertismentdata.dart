import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddData extends StatelessWidget {
  final String name;
  final String description;
  final String serviceName;
  final double rating;

  const AddData({
    required this.name,
    required this.description,
    required this.serviceName,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                Text('  ' + name),
                Expanded(
                  child: Rating(
                    rating: rating,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final double rating;
  const Rating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          itemCount: 5,
          itemSize: 20.0,
          direction: Axis.horizontal,
        ),
        Text(rating.toString() + '/5'),
      ],
    );
  }
}
