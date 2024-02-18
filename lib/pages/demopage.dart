import 'dart:developer';
import 'dart:io';

import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;



class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  Future<void> generatePDF() async {
log('dfasfas');
    // Create a new PDF document

  }

  @override
  Widget build(BuildContext context) {
        GetxTapController gcontroller =
        Get.put(GetxTapController(context: context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Generator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed:(){
            gcontroller.getDownloadReciept();
          },
          child: const Text('Generate PDF'),
        ),
      ),
    );
  }
}
