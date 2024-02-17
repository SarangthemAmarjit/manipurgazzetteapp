import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
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
    final pdf = pw.Document();

    // Add your desired widget to the PDF
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Hello World', style: const pw.TextStyle(fontSize: 40)),
        );
      },
    ));

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
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
