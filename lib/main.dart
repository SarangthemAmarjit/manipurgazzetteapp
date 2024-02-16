import 'dart:io';

import 'package:atompaymentdemo/pages/successpage.dart';
import 'package:atompaymentdemo/router/router.dart';
import 'package:atompaymentdemo/sevices/localnotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();


  await NotificationService().initNotification();

  runApp(const MyApp());
}

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      theme: ThemeData(
        fontFamily: 'KulimPark',
        useMaterial3: false,
      ),
      // home: const SuccessPage(
      //   transactionstatus: 'You Payment is Successful!',
      //   transactionid: 'GDSKLSLDFR',
      //   trasactionstatus: 200,
      // ),
    );
  }
}
