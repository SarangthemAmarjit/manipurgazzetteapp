import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String transactionstatus;
  const SuccessPage({super.key, required this.transactionstatus});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          'Transaction Done Successfully',
          style: TextStyle(fontSize: 30),
        ),
      )),
    );
  }
}
