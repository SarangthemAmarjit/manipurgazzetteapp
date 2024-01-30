import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/images/kanglasa.png')),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Manipur e-Gazette',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),

                Center(
                    child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: width / 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: Colors.blue),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'to',
                        style: TextStyle(
                            fontSize: width / 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            color: Colors.blue),
                      ),
                    ),
                    Text(
                      'Manipur E-Gazette',
                      style: TextStyle(
                          fontSize: width / 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                          color: Colors.blue),
                    ),
                  ],
                )),
                const SizedBox(
                  height: 10,
                ),
                const FittedBox(
                  child: Row(
                    children: [
                      Text(
                        'Directorate of Printing and Stationary, Government of Manipur, India',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),
                Card(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 253, 252),
                        borderRadius: BorderRadius.circular(7)),
                    height: 43,
                    child: TextFormField(
                      onChanged: ((value) {}),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 7),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)),
                        hintText: 'Search Gazette',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      width: 150,
                      height: 50,
                      child: const Center(
                        child: Text(
                          'Search Gazette',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )

                    // ElevatedButton(
                    //     onPressed: () {},
                    //     child: const Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 10),
                    //       child: Text('Search Gazette'),
                    //     )),
                    )
                // Add more cards for additional features
              ],
            ),
          ),
        ),
      ),
    );
  }
}
