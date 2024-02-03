// ignore: import_of_legacy_library_into_null_safe
import 'package:atompaymentdemo/router/router.gr.dart';
import 'package:atompaynetznonaes/atompaynetznonaes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  // to test uat try below
  final login = "197"; //mandatory
  final pass = 'Test@123'; //mandatory
  final prodid = 'NSE'; //mandatory
  final requesthashKey = 'KEY123657234'; //mandatory
  final responsehashKey = 'KEYRESP123657234'; //mandatory

  final amt = '10.00'; //mandatory
  final username = 'test user'; //optional
  final mobile = '8888888888'; //optional
  final email = 'test@gmail.com'; //optional
  final address = 'mumbai'; //optional
  final date =
      '12/06/2022 16:50:00'; //mandatory //current transaction date should be matching like this
  final txnid = '123456'; //mandatory // this should be unique each time
  final custacc = '0123456789'; //mandatory
  final clientcode = "NAVIN"; //mandatory
  final udf9 =
      "testdata1,testdata2,testdata3"; //optional, you can send comma seperated data here
  final mode = 'uat'; //mandatory // change to live for production

  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atom Paynetz Sample App'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _handleURLButtonPress(context, responsehashKey),
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleURLButtonPress(BuildContext context, String responsehashKey) {
    context.router
        .push(PaymentPage(url: getUrl(), resHashKey: responsehashKey));
  }

  getUrl() {
    var atompaynetznonaes = AtomPaynetzNonAes(
        login: login,
        pass: pass,
        prodid: prodid,
        amt: amt,
        username: username,
        mobile: mobile,
        email: email,
        address: address,
        date: date,
        clientcode: clientcode,
        txnid: txnid,
        custacc: custacc,
        udf9: udf9,
        requesthashKey: requesthashKey,
        responsehashKey: responsehashKey,
        mode: mode);
    var urlToSend = atompaynetznonaes.getUrl();
    return urlToSend;
  }
}
