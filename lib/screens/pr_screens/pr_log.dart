import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PRLogDetails extends StatefulWidget {
  const PRLogDetails({super.key});

  @override
  State<PRLogDetails> createState() => _PRLogDetailsState();
}

class _PRLogDetailsState extends State<PRLogDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Text',
              style: TextStyle(color: Colors.red, fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }
}
