import 'package:flutter/material.dart';

import '../../domain/entities/number_trivia.dart';

class TriviaDisplayWidget extends StatelessWidget {
  const TriviaDisplayWidget({
    super.key,
    required this.context,
    required this.numberTrivia,
  });

  final BuildContext context;
  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 2 / 3,
      child: Column(
        children: [
          Text(numberTrivia.number.toString(),
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold,)),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}