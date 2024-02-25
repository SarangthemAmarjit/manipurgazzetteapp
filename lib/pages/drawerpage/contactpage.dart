import 'package:atompaymentdemo/widget/contactwidget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 241, 253),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        'CONTACT',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Card(
                    elevation: 5,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        children: [
                          Icon(
                            Icons.place,
                            color: Colors.blue,
                            size: 35,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Our Address',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Manipur Secretariat North Block, Indo-Myanmar Road, Babupara, Imphal, Manipur',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.blue,
                              size: 35,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Call Us',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            ContactDetail(
                              name: 'Athokpam Romita Devi',
                              designation: 'Director, Printing & Stationary',
                              phoneNumber: '0385-2450202',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(elevation: 5,
                    child: Padding(
                                       padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                      child: SizedBox(   width: MediaQuery.of(context).size.width,
                        child: const Column(
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.blue,
                              size: 35,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Call Us',
                              style:
                                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            ContactDetail(
                              name: 'Th. Binodkumar Singh',
                              designation: 'Assistant Director',
                              phoneNumber: '0385-2450202',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
