// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

class DateFieldWidget extends StatelessWidget {
  final bool ispublishfrom;
  DateFieldWidget({super.key, required this.ispublishfrom});

  var format = DateFormat("dd-MM-yyyy");
  DateTime? firstdate = DateTime(1950, 01, 01);
  DateTime? lastdate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController());
    double screenWidth = MediaQuery.of(context).size.width;
    log(screenWidth.toString());
    double textSize = screenWidth * 0.031;
    return GetBuilder<GetxTapController>(builder: (_) {
      return DateTimeField(
        style: TextStyle(fontSize: screenWidth < 400 ? textSize : 15),
        textAlign: TextAlign.center,
        autocorrect: true,
        resetIcon: const Icon(Icons.restore),
        onChanged: (value) {
          ispublishfrom
              ? gcontroller.onchangepublishfrom(value: value!)
              : gcontroller.onchangepublishtill(value: value!);
        },
        readOnly: false,
        controller: ispublishfrom
            ? gcontroller.publishfromcontroller
            : gcontroller.publishtillcontroller,
        decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () async {
                return showDatePicker(
                        context: context,
                        initialDate: ispublishfrom
                            ? gcontroller.publishFrominitialdate
                            : gcontroller.publishTillinitialdate,
                        firstDate: firstdate!,
                        lastDate: lastdate!,
                        // helpText: "SELECT DATE OF BIRTH",
                        cancelText: "CANCEL",
                        confirmText: "OK",
                        fieldHintText: "DATE/MONTH/YEAR",
                        fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                        errorFormatText: "Enter a Valid Date",
                        errorInvalidText: "Date Out of Range")
                    // ignore: void_checks
                    .then((value) {
                  ispublishfrom
                      ? gcontroller.iconbuttondatepickerpublishfrom(
                          value: value!)
                      : gcontroller.iconbuttondatepickerpublishtill(
                          value: value!);

                  return value;
                });
              },
              icon: const Icon(Icons.calendar_today),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
                  context: context,
                  initialDate: ispublishfrom
                      ? gcontroller.publishFrominitialdate
                      : gcontroller.publishTillinitialdate,
                  firstDate: firstdate!,
                  lastDate: lastdate!,
                  // helpText: "SELECT DATE OF BIRTH",
                  cancelText: "CANCEL",
                  confirmText: "OK",
                  fieldHintText: "DATE/MONTH/YEAR",
                  fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                  errorFormatText: "Enter a Valid Date",
                  errorInvalidText: "Date Out of Range")
              .then((value) {
            ispublishfrom
                ? gcontroller.iconbuttondatepickerpublishfrom(value: value!)
                : gcontroller.iconbuttondatepickerpublishtill(value: value!);

            return value;
          });
        },
      );
    });
  }
}
