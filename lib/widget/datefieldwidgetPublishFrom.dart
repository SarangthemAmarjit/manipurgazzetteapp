// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

class DateFieldWidgetpublishFrom extends StatelessWidget {
  DateFieldWidgetpublishFrom({
    super.key,
  });

  var format = DateFormat("dd-MM-yyyy");
  DateTime? firstdate = DateTime(1950, 01, 01);
  DateTime? lastdate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController(context: context));
    double screenWidth = MediaQuery.of(context).size.width;
    log(screenWidth.toString());
    double textSize = screenWidth * 0.031;
    return GetBuilder<GetxTapController>(builder: (_) {
      return DateTimeField(
        style: TextStyle(fontSize: screenWidth < 400 ? textSize : 15),
        textAlign: TextAlign.center,
        resetIcon: const Icon(Icons.restore),
        controller: gcontroller.publishfromcontroller,
        decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () async {
                return showDatePicker(
                        context: context,
                        initialDate: gcontroller.publishFrominitialdate,
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
                  gcontroller.iconbuttondatepickerpublishfrom(value: value!);

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
                  initialDate: gcontroller.publishFrominitialdate,
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
            gcontroller.iconbuttondatepickerpublishfrom(value: value!);

            return value;
          });
        },
      );
    });
  }
}
