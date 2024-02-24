import 'dart:io';

import 'package:atompaymentdemo/pages/demopage.dart';
import 'package:atompaymentdemo/pages/successpage.dart';
import 'package:atompaymentdemo/router/router.dart';
import 'package:atompaymentdemo/sevices/localnotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();


  await NotificationService().initNotification();
    FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  runApp(const MyApp());
}

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Change the color as desired
    ));
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: 'E-Gazette',
      builder: EasyLoading.init(),
      theme: ThemeData(
        fontFamily: 'KulimPark',
        useMaterial3: false,
      ),);
      // home: const SuccessPage(transactionstatus: 'Payment Successfull', transactionid: 'ADKSHSKDJ', trasactionstatus: 200, paymentmethodname: 'Debit', totalamount: '3',));
  }
}
