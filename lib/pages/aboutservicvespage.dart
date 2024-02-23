import 'package:atompaymentdemo/constant/constant.dart';
import 'package:atompaymentdemo/widget/noglow.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AboutServicePage extends StatelessWidget {
  final int index;
  const AboutServicePage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {

        // Get the screen size
    Size screenSize = MediaQuery.of(context).size;

    // Calculate the text size based on the screen width
    double textSize = screenSize.width * 0.028; 
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Image.asset(
            'assets/images/kanglasa.png',
          ),
        ),
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Manipur e-Gazette',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
      body: ScrollConfiguration(     behavior: NoGlowScrollBehavior(),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Text(
                          servicesmessage[index]['name'],
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),const SizedBox(height: 50,),
                    
                        Text(servicesmessage[index]['details'],textAlign: TextAlign.justify,
                          style:  TextStyle(
                              fontSize: textSize,height: 1.2 )),       const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                )),
          )),
        ),
      ),
    );
  }
}
