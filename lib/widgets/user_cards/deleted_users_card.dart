import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class DeletedUserCard extends StatelessWidget {
  const DeletedUserCard({
    Key? key,
    this.ht,
    this.wd,
    required this.userName,
    this.emailId,
    this.role,
    this.department,
    this.duration,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final String? userName;
  final String? emailId;
  final String? role;
  final String? department;

  final dynamic duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          elevation: 8,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: duration),
            height: ht,
            width: wd,
            decoration: ColorCards.gradientDecoration,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'User Name:  $userName',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Email ID:  $emailId',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Role:  $role',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 18, bottom: 5),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Department:  $department',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
