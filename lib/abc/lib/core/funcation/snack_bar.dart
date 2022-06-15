import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(
      SnackBar(backgroundColor: Colors.red,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(message.toString()),
              const Icon(Icons.error_outline)
            ],
          ),
        )));
}