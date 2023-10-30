import 'package:flutter/material.dart';

class DogBreedItem extends StatelessWidget {
  final String? dog;

  const DogBreedItem({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white, // You can set the desired color here
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 7,
            spreadRadius: 5,
            offset: const Offset(1, 4),
          )
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(dog!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
