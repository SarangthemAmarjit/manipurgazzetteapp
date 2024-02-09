import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


@RoutePage()
class SuccessPage extends StatelessWidget {
  final String transactionstatus;
  final String transactionid;
  const SuccessPage({super.key, required this.transactionstatus, required this.transactionid});

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
