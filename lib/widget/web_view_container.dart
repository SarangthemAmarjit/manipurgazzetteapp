// ignore: import_of_legacy_library_into_null_safe
import 'dart:developer';

import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:atompaynetznonaes/atompaynetznonaes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  final resHashKey;
  const WebViewContainer(this.url, this.resHashKey, {super.key});
  @override
  createState() => _WebViewContainerState(url, resHashKey);
}

class _WebViewContainerState extends State<WebViewContainer> {
  final _url;
  final _resHashKey;
  final _key = UniqueKey();
  late WebViewController _controller;
  bool? ispageloaded;
  _WebViewContainerState(this._url, this._resHashKey);
  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 2,
        ),
        body: GetBuilder<GetxTapController>(builder: (_) {
          return Column(
            children: [
              Expanded(
                  child: Stack(children: [
                WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    gcontroller.onwebviewcreated();
                    _controller = controller;
                    log('created');
                  },
                  onPageStarted: (url) {
                    log('started');
                  },
                  initialUrl: _url,
                  onPageFinished: (String url) async {
                    log('finish');
                    gcontroller.onwebviewcreatedfinish();
                    if (url.contains('/mobilesdk/param')) {
                      // print('onPageFinished blocking navigation to $url}');
                      final response =
                          await _controller.runJavascriptReturningResult(
                              "(function() { let htmlH5 = document.getElementsByTagName('h5')[0].innerHTML; return htmlH5; })();");
                      log(response);

                      List responseArray = [];
                      var responseMap = {};
                      var splitRawResponse = response
                          .trim()
                          .split('|')
                          .map((text) => text)
                          .toList();
                      for (var i = 0; i < splitRawResponse.length; i++) {
                        if (splitRawResponse[i].isNotEmpty &&
                            splitRawResponse[i].length > 2) {
                          var splitNewResponse = splitRawResponse[i]
                              .trim()
                              .split('=')
                              .map((text) => text)
                              .toList();
                          responseArray.add(splitNewResponse);
                        }
                      }
                      for (var i = 0; i < responseArray.length; i++) {
                        responseMap[responseArray[i][0]] = responseArray[i][1];
                      }
                      var atompaynetznonaes = VerifyTransaction();
                      var checkFinalTransaction = atompaynetznonaes
                          .validateSignature(responseMap, _resHashKey);
                      var transactionResult = "";
                      if (checkFinalTransaction) {
                        if (responseMap['f_code'] == 'success_00' ||
                            responseMap['f_code'] == 'Ok') {
                          transactionResult = "success";
                        } else if (responseMap['f_code'] == 'C_06' ||
                            responseMap['f_code'] == 'C') {
                          transactionResult = "cancelled";
                        } else {
                          transactionResult = "failed";
                        }
                      } else {
                        // ignore: avoid_print
                        print("signature mismatched");
                        transactionResult = "failed";
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context); // Close current window
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Transaction Status = $transactionResult")));
                    }
                  },
                  gestureNavigationEnabled: true,
                ),
                if (gcontroller.isloading)
                  const Center(
                    child: Text(
                      'Please wait...',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
              ]))
            ],
          );
        }));
  }
}

// class MyWebView extends StatefulWidget {
//   @override
//   _MyWebViewState createState() => _MyWebViewState();
// }

// class _MyWebViewState extends State<MyWebView> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   bool _isLoading = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Web View with Progress Indicator'),
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl: 'https://example.com', // Replace with your URL
//             onWebViewCreated: (WebViewController webViewController) {
//               _controller.complete(webViewController);
//             },
//             onPageStarted: (String url) {
//               setState(() {
//                 _isLoading = true;
//               });
//             },
//             onPageFinished: (String url) {
//               setState(() {
//                 _isLoading = false;
//               });
//             },
//           ),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }
