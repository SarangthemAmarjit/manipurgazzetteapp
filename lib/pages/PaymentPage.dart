import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:atompaymentdemo/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:atompaymentdemo/controller/atom_pay_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class PaymentPage extends StatefulWidget {
  final mode;
  final payDetails;
  final responsehashKey;
  final responseDecryptionKey;

  const PaymentPage(this.mode, this.payDetails, this.responsehashKey,
      this.responseDecryptionKey,
      {super.key});

  @override
  createState() => _PaymentPageState(
      mode, payDetails, responsehashKey, responseDecryptionKey);
}

class _PaymentPageState extends State<PaymentPage> {
  final mode;
  final payDetails;
  final _responsehashKey;
  final _responseDecryptionKey;
  final _key = UniqueKey();
  late InAppWebViewController _controller;

  final Completer<InAppWebViewController> _controllerCompleter =
      Completer<InAppWebViewController>();

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform  = SurfaceAndroidViewController();
  }

  _PaymentPageState(this.mode, this.payDetails, this._responsehashKey,
      this._responseDecryptionKey);

  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller =
        Get.put(GetxTapController(context: context));
    return WillPopScope(
      onWillPop: () => _handleBackButtonAction(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 2,
        ),
        body: SafeArea(
            child: InAppWebView(
          // initialUrl: 'about:blank',
          key: UniqueKey(),
          onWebViewCreated: (InAppWebViewController inAppWebViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(inAppWebViewController);

            debugPrint("payDetails from webview $payDetails");
            _loadHtmlFromAssets(mode);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            String url = navigationAction.request.url.toString();
            var uri = navigationAction.request.url!;
            if (url.startsWith("upi://")) {
              debugPrint("upi url started loading");
              try {
                await launchUrl(uri);
              } catch (e) {
                _closeWebView(
                    context: context,
                    transactionResult:
                        "Transaction Status = cannot open UPI applications",
                    txid: '',
                    transstatus: 0);

                throw 'custom error for UPI Intent';
              }
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          },

          onLoadStop: (controller, url) async {
            debugPrint("onloadstop_url: $url");

            if (url.toString().contains("AIPAYLocalFile")) {
              debugPrint(" AIPAYLocalFile Now url loaded: $url");
              await _controller.evaluateJavascript(
                  source: "${"openPay('" + payDetails}')");

              log('Checking 1 $url');
            }

            if (url.toString().contains('/mobilesdk/param')) {
              log('Checking 2');
              final String response = await _controller.evaluateJavascript(
                  source: "document.getElementsByTagName('h5')[0].innerHTML");
              debugPrint("HTML response : $response");
              var transactionResult = "";
              String transactionid = '';
              int? transactionstatus;

              if (response.trim().contains("cancelTransaction")) {
                gcontroller.updatepaymentremark(
                    transactionid: gcontroller.transacid,
                    remark: 'Payment Cancelled');
                transactionResult = "Transaction Cancelled!";
                transactionstatus = 100;
              } else {
                final split = response.trim().split('|');
                final Map<int, String> values = {
                  for (int i = 0; i < split.length; i++) i: split[i]
                };

                final splitTwo = values[1]!.split('=');
                const platform = MethodChannel('flutter.dev/NDPSAESLibrary');

                try {
                  final String result =
                      await platform.invokeMethod('NDPSAESInit', {
                    'AES_Method': 'decrypt',
                    'text': splitTwo[1].toString(),
                    'encKey': _responseDecryptionKey
                  });
                  var respJsonStr = result.toString();
                  Map<String, dynamic> jsonInput = jsonDecode(respJsonStr);
                  debugPrint("read full respone : $jsonInput");

                  //calling validateSignature function from atom_pay_helper file
                  var checkFinalTransaction =
                      validateSignature(jsonInput, _responsehashKey);

                  if (checkFinalTransaction) {
                    if (jsonInput["payInstrument"]["responseDetails"]
                                ["statusCode"] ==
                            'OTS0000' ||
                        jsonInput["payInstrument"]["responseDetails"]
                                ["statusCode"] ==
                            'OTS0551') {
                      gcontroller.updatepaymentremark(
                          transactionid: transactionid,
                          remark: 'Payment Success');
                      debugPrint("Transaction success");
                      transactionid = jsonInput['payInstrument']['merchDetails']
                          ['merchTxnId'];
                      gcontroller.updatepaymentremark(
                          transactionid: transactionid,
                          remark: 'Payment Success');

                      transactionResult = "Transaction Success";
                      transactionstatus = 200;
                    } else {
                      gcontroller.updatepaymentremark(
                          transactionid: transactionid,
                          remark: 'Transaction Fail');
                      debugPrint("Transaction failed");
                      transactionResult = "Transaction Failed";
                      transactionstatus = 300;
                    }
                  } else {
                    gcontroller.updatepaymentremark(
                        transactionid: transactionid, remark: 'Payment Fail');
                    debugPrint("signature mismatched");
                    transactionResult = "failed";
                  }
                  debugPrint("Transaction Response : $jsonInput");
                } on PlatformException catch (e) {
                  debugPrint("Failed to decrypt: '${e.message}'.");
                }
              }
              // ignore: use_build_context_synchronously
              _closeWebView(
                  context: context,
                  transactionResult: transactionResult,
                  txid: transactionid,
                  transstatus: transactionstatus!);
            }
          },
        )),
      ),
    );
  }

  _loadHtmlFromAssets(mode) async {
    final localUrl = mode == 'uat'
        ? "assets/payment/aipay_uat.html"
        : "assets/payment/aipay_prod.html";
    String fileText = await rootBundle.loadString(localUrl);
    _controller.loadUrl(
        urlRequest: URLRequest(
            url: WebUri(
      Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    )));
  }

  _closeWebView(
      {required BuildContext context,
      required String transactionResult,
      required int transstatus,
      required String txid}) {
    // ignore: use_build_context_synchronously
    context.router.push(SuccessPage(
        transactionstatus: transactionResult,
        transactionid: txid,
        trasactionstatus: transstatus));

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Transaction Status = $transactionResult")));
  }

  Future<bool> _handleBackButtonAction(BuildContext context) async {
    debugPrint("_handleBackButtonAction called");
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Do you want to exit the payment ?'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                // ignore: deprecated_member_use
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pop(); // Close current window
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Transaction Status = Transaction cancelled")));
                  },
                  child: const Text('Yes'),
                ),
              ],
            ));
    return Future.value(true);
  }

  ///////////////////////////
}
