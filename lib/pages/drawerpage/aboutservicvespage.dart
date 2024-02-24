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
                        height: 20,
                      ),
                             Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 241, 253),
                        borderRadius: BorderRadius.circular(20)),
                    child:  Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        servicesmessage[index]['name'],
                        style: const TextStyle(
                            letterSpacing: 2,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                    const SizedBox(height: 30,),
                  
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(servicesmessage[index]['details'],textAlign: TextAlign.justify,
                            style:  TextStyle(
                                fontSize: textSize,height: 1.2 )),
                        ),
                      ),       const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )),
        )),
      ),
    );
  }
}
