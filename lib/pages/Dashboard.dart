import 'dart:developer';
import 'dart:io';

import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:atompaymentdemo/router/router.gr.dart';
import 'package:atompaymentdemo/widget/drawerWidget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

@RoutePage()
class DashBoardPage extends StatelessWidget {
  DashBoardPage({super.key});

  TextEditingController searchcontroller = TextEditingController();
    final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller =
        Get.put(GetxTapController(context: context));
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => context.router.pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child:
      
      
      
       AdvancedDrawer( backdropColor: const Color.fromARGB(255, 219, 252, 248).withOpacity(0.3),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeIn,

        animationDuration: const Duration(milliseconds: 250),
        animateChildDecoration: true,
        rtlOpening: false,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: const drawerWidget(),
         child: Scaffold(
          appBar: AppBar(
          
            backgroundColor: Colors.white,
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
              padding: const EdgeInsets.only( top: 10, bottom: 5,right: 10),
              child: Image.asset(
                'assets/images/kanglasa.png',height: kToolbarHeight * 0.8,
              ),
            ),
                const Text(
                  'Manipur e-Gazette',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ), leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,color: Colors.black,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            )
          ),
          backgroundColor: Colors.white,
          body: GetBuilder<GetxTapController>(builder: (_) {
            return Container(
              decoration: const BoxDecoration(color:Colors.white),

              
                  // image: gcontroller.imagefile != null
                  //     ? DecorationImage(
                  //         opacity: 0.4,
                  //         fit: BoxFit.cover,
                  //         image: FileImage(gcontroller.imagefile!),
                  //       )
                  //     : const DecorationImage(
                  //         opacity: 0.4,
                  //         fit: BoxFit.cover,
                  //         image: AssetImage('assets/images/bgok.jpg'))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     SizedBox(
                        //         height: 50,
                        //         child: Image.asset('assets/images/kanglasa.png')),
                        //     const Padding(
                        //       padding: EdgeInsets.only(left: 10),
                        //       child: Text(
                        //         'Manipur e-Gazette',
                        //         style: TextStyle(
                        //             fontSize: 25, fontWeight: FontWeight.bold),
                        //       ),
                        //     )
                        //   ],
                        // ),
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
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.blue,
                                letterSpacing: 6,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'to',
                                style: TextStyle(
                                  fontSize: width / 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Colors.blue,
                                ),
                              ),
                            ),
                            Text(
                              'Manipur E-Gazette',
                              style: TextStyle(
                                fontSize: width / 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.blue,
                              ),
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
                        Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              elevation: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 253, 253, 252),
                                    borderRadius: BorderRadius.circular(7)),
                                height: 43,
                                child: Focus(
                                  onFocusChange: (value) {
                                    gcontroller.onfocuschange(
                                        value: value,
                                        searchtext: searchcontroller.text);
                                  },
                                  child: TextFormField(onEditingComplete: () {
                                           gcontroller.validateInput(searchcontroller.text);
                            if (gcontroller.validationError == null) {
                              // Form is valid, proceed with your logic
                              gcontroller.getsearchdata(
                                  value: searchcontroller.text);
                              context.router.push(SearchPage());
         
                              gcontroller.getDeapartment();
                            }
                                  },
                                    controller: searchcontroller,
                                    onChanged: ((value) {
                                      gcontroller.validateInput(value);
                                    }),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(top: 7),
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        hintText: 'Search Gazette',
                                        hintStyle:
                                            const TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
         
                        if (gcontroller.validationError != null)
                          Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  gcontroller.validationError!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            gcontroller.validateInput(searchcontroller.text);
                            if (gcontroller.validationError == null) {
                              // Form is valid, proceed with your logic
                              gcontroller.getsearchdata(
                                  value: searchcontroller.text);
                              context.router.push(SearchPage());
         
                              gcontroller.getDeapartment();
                            }
                          },
                          child: Card(
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              )
         
                              // ElevatedButton(
                              //     onPressed: () {},
                              //     child: const Padding(
                              //       padding: EdgeInsets.symmetric(vertical: 10),
                              //       child: Text('Search Gazette'),
                              //     )),
                              ),
                        )
                        // Add more cards for additional features
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
               ),
       ),
    );
  }
}
