import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:atompaymentdemo/constant/constant.dart';
import 'package:atompaymentdemo/model/searchmodel.dart';
import 'package:atompaymentdemo/pages/searchpage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

class GetxTapController extends GetxController {
  final BuildContext context;

  GetxTapController({required this.context});
  //table
  EmployeeDataSource? _employeeDataSource;

  final List<Employee> _employees = <Employee>[];

  //DateField


  //POSTAL ADRRESS
final TextEditingController  _billingnamecontroller = TextEditingController();
final TextEditingController  _billingaddresscontroller = TextEditingController();
final TextEditingController  _billingpincodecontroller = TextEditingController();

//PublishTill
  TextEditingController _publishtillcontroller = TextEditingController();
  String _publishTilldate = '';

  DateTime _publishTillinitialdate = DateTime.now();

//PublishFrom
  TextEditingController _publishfromcontroller = TextEditingController();

  String _publishfromdate = '01-01-1950';

  DateTime _publishfrominitialdate = DateTime(1950, 01, 01);

  //

  bool _isloading = true;
  
  bool _ischecked = false;
  File? _imagefile;

  TextEditingController get publishtillcontroller => _publishtillcontroller;
  TextEditingController get publishfromcontroller => _publishfromcontroller;

  
  TextEditingController get billingnamecontroller => _billingnamecontroller;
  TextEditingController get billingaddresscontroller => _billingaddresscontroller;
   TextEditingController get billingpincodecontroller => _billingpincodecontroller;


AllSearchResultData? allsearchdata;
var isDataLoading = false.obs;
  String get publishTilldate => _publishTilldate;
  String get publishFromdate => _publishfromdate;
  DateTime get publishTillinitialdate => _publishTillinitialdate;
  DateTime get publishFrominitialdate => _publishfrominitialdate;

  EmployeeDataSource get employeeDataSource => _employeeDataSource!;
  bool get isloading => _isloading;
  bool get ischecked => _ischecked;
  File? get imagefile => _imagefile;

  @override
  Future<void> onInit() async {
    super.onInit();
    gettodaydate();
    getEmployeeData();
    await downloadAndSaveGif(
        'https://firebasestorage.googleapis.com/v0/b/manipur-e-gazette.appspot.com/o/bg.gif?alt=media&token=d7769401-361c-4ab1-9a2a-cb74fdcb26d5');
  }

  void onwebviewcreated() {
    _isloading = true;
    update();
  }

  //getSearchData


    Future getsearchdata({required String searchtext}) async {
    if (allsearchdata == null) {
      isDataLoading(true);
    }
    try {
      final queryParameters = {
        "text": searchtext,
      };
      final response = await http.get(
        Uri.http('10.10.1.139:8099', '/api/gazettes/text',
            queryParameters),
      );

      if (response.statusCode == 200) {

        var users = allSearchResultDataFromJson(response.body);

        if (allsearchdata == null) {
          // allsearchdata = users;
          // _latestfeeddata = allsearchdata!.feeds.last;

          update();
        } else {
          if (users == allsearchdata) {
            log('Data Already same');
          } else {
            isDataLoading(true);
            // allsearchdata = users;
            // _latestfeeddata = allsearchdata!.feeds.last;

            update();
          }
        }
      } else {
        print('Failedrerer to Getdata.');
        _isserverok = false;
        update();
      }
      return null;
    } catch (e) {
      _isserverok = false;
      update();
      print(e.toString());
    } finally {
      isDataLoading(false);
    }
  }

  //getTabledata
  getEmployeeData() {
    for (int i = 0; i < alldata.length; i++) {
      _employees.add(Employee(
        alldata[i]['id'],
        alldata[i]['name'],
        alldata[i]['designation'],
      ));
    }
    _employeeDataSource =
        EmployeeDataSource(employees: _employees, context: context);
    update();
  }

//PUBLISHFROM FUNCTIONS
  void iconbuttondatepickerpublishfrom({required DateTime value}) {
    _publishfromcontroller.text = "${value.day}-${value.month}-${value.year}";
    _publishfrominitialdate = value;
    update();
  }

  void onchangepublishfrom({required DateTime value}) {
    _publishfromcontroller.text = "${value.day}-${value.month}-${value.year}";
    _publishfrominitialdate = value;
    _publishfromdate = "${value.day}-${value.month}-${value.year}";
    update();
  }

  //PUBLISHTILL FUNCTIONS

  gettodaydate() {
    DateTime now = DateTime.now();

    int day = now.day;
    int month = now.month;
    int year = now.year;
    _publishfromcontroller = TextEditingController(text: '1-1-1950');
    _publishtillcontroller = TextEditingController(text: '$day-$month-$year');
    _publishTilldate = '$day-$month-$year';
    update();
  }

  void iconbuttondatepickerpublishtill({required DateTime value}) {
    log('iconbuttondatepickerpublishtill');
    _publishtillcontroller.text = "${value.day}-${value.month}-${value.year}";
    _publishTillinitialdate = value;
    update();
  }

  void onchangepublishtill({required DateTime value}) {
    _publishfromcontroller.text = "${value.day}-${value.month}-${value.year}";
    _publishfrominitialdate = value;
    _publishTilldate = "${value.day}-${value.month}-${value.year}";
    update();
  }

  Future<bool> doesFileExist(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    return await file.exists();
  }

  Future<void> downloadAndSaveGif(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/background.gif');
    log(file.path);

    bool fileExists = await doesFileExist('background.gif');
    print('File exists: $fileExists');

    if (fileExists) {
      log('file found');
      _imagefile = file;
      update();
    } else {
      try {
        final response = await http.get(Uri.parse(url));
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes).then((value) {
            _imagefile = file;
            update();
          });
        }
      } catch (e, stackTrace) {
        log('Error in downloadAndSaveGif: $e');
        log('$stackTrace');
        // Handle the error gracefully, you may choose to show a default image.
      }
      log('file not found');
    }
  }

  void onwebviewcreatedfinish() {
    _isloading = false;
    update();
  }

  void setcheckbox({required bool value,required String name,required String address,required String pincode}){
_ischecked = value;
if(value){
  _billingnamecontroller.text = name;
    _billingaddresscontroller.text = address;
      _billingpincodecontroller.text = pincode;
      update();
}else{
  _billingnamecontroller.clear();
    _billingaddresscontroller.clear();
      _billingpincodecontroller.clear();
      update();
}
update();
  }
}
