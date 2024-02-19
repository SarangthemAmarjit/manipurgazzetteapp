import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';


class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  Future<void> generatePDF() async {
      var date = DateTime.now();

   var   transactiondate = DateFormat('dd/MM/yyyy').add_jm().format(date);
   log(date.toString());
      log(transactiondate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Generator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: generatePDF,
          child: const Text('Generate PDF'),
        ),
      ),
    );
  }
}
