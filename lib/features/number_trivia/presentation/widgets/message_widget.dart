import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  const MessageDisplayWidget({
    super.key,
    required this.context,
    required this.message,
  });

  final BuildContext context;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 2 / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}