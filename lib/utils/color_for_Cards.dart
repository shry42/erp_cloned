import 'package:flutter/material.dart';

class ColorCards {
  static BoxDecoration gradientDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    gradient: const LinearGradient(
      colors: <Color>[
        Color.fromARGB(243, 84, 86, 80),
        Color.fromARGB(255, 151, 223, 126),
      ],
    ),
  );
}
