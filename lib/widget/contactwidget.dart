import 'package:flutter/material.dart';

class ContactDetail extends StatelessWidget {
  final String name;
  final String designation;
  final String phoneNumber;

  const ContactDetail({
    Key? key,
    required this.name,
    required this.designation,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5,),
        Text(
          designation,
          style: const TextStyle(fontSize: 14),
        ),
          const SizedBox(height: 5,),
        Text(
          phoneNumber,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}