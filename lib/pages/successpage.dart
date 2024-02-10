import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

@RoutePage()
class SuccessPage extends StatelessWidget {
  final String transactionstatus;
  final int trasactionstatus;
  final String transactionid;
  const SuccessPage(
      {super.key,
      required this.transactionstatus,
      required this.transactionid,
      required this.trasactionstatus});

  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller =
        Get.put(GetxTapController(context: context));
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<GetxTapController>(builder: (_) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    trasactionstatus == 100
                        ? Image.asset(
                            'assets/images/cancel.gif',
                            height: 130,
                          )
                        : trasactionstatus == 200
                            ? Gif(
                                height: 130,
                                autostart: Autostart.once,
                                image: const AssetImage(
                                    'assets/images/paymentsuccess.gif'),
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                'assets/images/fail.png',
                                height: 130,
                              ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      transactionstatus,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Transaction ID : $transactionid'),
                    const SizedBox(
                      height: 10,
                    ),
                    trasactionstatus == 200
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      'Your Gazzette File is Generated :'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      gcontroller.getDownloadfile(
                                          trnxid: transactionid);
                                    },
                                    //              child: const SizedBox(
                                    //   height: 20,
                                    //   child: SizedBox(
                                    //       width: 20, child: CircularProgressIndicator()),
                                    // ),
                                    child: SizedBox(
                                      height: 20,
                                      child: gcontroller.isdownloadedfile ==
                                              null
                                          ? Image.asset(
                                              'assets/images/download.gif',
                                            )
                                          : gcontroller.isdownloadedfile!
                                              ? Image.asset(
                                                  'assets/images/check.gif')
                                              : const SizedBox(
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator()),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              gcontroller.isdownloadedfile != null &&
                                      gcontroller.isdownloadedfile!
                                  ? ElevatedButton(
                                      onPressed: () {
                                        context.router.replaceNamed('/');
                                      },
                                      child: const Text('Back to Home'))
                                  : const SizedBox()
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              context.router.replaceNamed('/');
                            },
                            child: const Text('Back to Home'))
                  ],
                ),
              ),
            ),
          ),
        ));
      }),
    );
  }
}
