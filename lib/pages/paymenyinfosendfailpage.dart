import 'package:flutter/material.dart';

class ProceedfailPage extends StatelessWidget {
  const ProceedfailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      
      body: SafeArea(child: Center(child: Image.asset('assets/images/error.png',height: 140),)),);
  }
}