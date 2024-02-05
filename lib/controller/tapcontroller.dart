import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:atompaymentdemo/constant/constant.dart';
import 'package:atompaymentdemo/model/searchmodel.dart';
import 'package:atompaymentdemo/pages/searchpage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  String? _validationError;
  String?get validationError=>_validationError;

  List<Employee> get employee => _employees;
  //DateField

  //POSTAL ADRRESS
  final TextEditingController _billingnamecontroller = TextEditingController();
  final TextEditingController _billingaddresscontroller =
      TextEditingController();
  final TextEditingController _billingpincodecontroller =
      TextEditingController();

//PublishTill
  TextEditingController _publishtillcontroller = TextEditingController();
  String _publishTilldate = '';

  DateTime _publishTillinitialdate = DateTime.now();

//PublishFrom
  TextEditingController _publishfromcontroller = TextEditingController();

  String _publishfromdate = '01-01-1950';

  DateTime _publishfrominitialdate = DateTime(1950, 01, 01);

  //
String searchtextvalue = '';

  String _billingdropdownvalue = '';
  String _postaldropdownvalue = '';

  String get billingdropdownvalue => _billingdropdownvalue;
  String get postaldropdownvalue => _postaldropdownvalue;

  bool _isloading = true;
  bool _isdataempty=false;

  bool _ischecked = false;
  File? _imagefile;

  TextEditingController get publishtillcontroller => _publishtillcontroller;
  TextEditingController get publishfromcontroller => _publishfromcontroller;

  TextEditingController get billingnamecontroller => _billingnamecontroller;
  TextEditingController get billingaddresscontroller =>
      _billingaddresscontroller;
  TextEditingController get billingpincodecontroller =>
      _billingpincodecontroller;

  List<AllSearchResultData> _allsearchdata = [];
  List<AllSearchResultData> get allsearchdata => _allsearchdata;
  var isDataLoading = false.obs;

  String get publishTilldate => _publishTilldate;
  String get publishFromdate => _publishfromdate;
  DateTime get publishTillinitialdate => _publishTillinitialdate;
  DateTime get publishFrominitialdate => _publishfrominitialdate;

  EmployeeDataSource? get employeeDataSource => _employeeDataSource;
  bool get isloading => _isloading;
    bool get isdataempty => _isdataempty;
  bool get ischecked => _ischecked;
  File? get imagefile => _imagefile;

  @override
  Future<void> onInit() async {
    super.onInit();
    gettodaydate();
  
    await downloadAndSaveGif(
        'https://firebasestorage.googleapis.com/v0/b/manipur-e-gazette.appspot.com/o/bg.gif?alt=media&token=d7769401-361c-4ab1-9a2a-cb74fdcb26d5');
  }

  void onwebviewcreated() {
    _isloading = true;
    update();
  }

 

  void validateInput(String value) {
    // Reset previous validation error

      _validationError = null;
      update();
   

    // Check for null or empty string
    if (value.isEmpty) {

        _validationError = 'Search Field Cannot be Empty';
             update();

      return;
    }

    // Check for length between 5 and 15 characters
    if (value.length < 5 || value.length > 15) {

        _validationError = 'Enter characters between 5 to 15';
             update();

      return;
    }

    // Check for special characters or white spaces
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {

        _validationError = 'Avoid special characters and white spaces';
             update();
      }
      return;
    }

  

  //getSearchData

  Future getsearchdata({required String value}) async {
searchtextvalue = value;
update();

    isDataLoading(true);

    try {
      final queryParameters = {
        "text": value,
      };
      final response = await http.get(
        Uri.http('10.10.1.139:8099', '/api/gazettes/text', queryParameters),
      );
log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.body);
        var users = allSearchResultDataFromJson(response.body);
        if(users.isEmpty){
            isDataLoading(false);
            _isdataempty = true;
          EasyLoading.showError('Record Not Found');
        }
        _allsearchdata = users;

        update();
        log('users$users');
     getEmployeeData();
    isDataLoading(false);
      } else {
        print('Failedrerer to Getdata.');
        //  _isserverok = false;
      }
      return null;
    } catch (e) {
      // _isserverok = false;

      print(e.toString());
    } 
  }

  //getTabledata
  getEmployeeData() {
   for (int i = 0; i < _allsearchdata.length; i++) {
          _employees.add(Employee(
              gazettenumber: _allsearchdata[i].gazetteno,
              title: _allsearchdata[i].title,
              totalpage: _allsearchdata[i].totalpages,
              gazetid: _allsearchdata[i].gazetteId));
        }
        _employeeDataSource =
            EmployeeDataSource(employees: _employees, context: context);
        update();
  }

  Future<bool> handlePageChange(int newPageIndex) async {
    int startIndex = newPageIndex * 10;
    int endIndex = startIndex + 10;
    log('startIndex ${startIndex.toString()}');
    log('endIndex ${endIndex.toString()}');
    if (startIndex < _employees.length && endIndex <= _employees.length) {
      _employeeDataSource = EmployeeDataSource(
          employees:
              _employees.getRange(startIndex, endIndex).toList(growable: false),
          context: context);
      update();
    } else if (endIndex > _employees.length) {
      _employeeDataSource = EmployeeDataSource(
          employees: _employees
              .getRange(startIndex, _employees.length)
              .toList(growable: false),
          context: context);
      update();
    } else {
      _employeeDataSource = null;
    }

    return true;
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

  void setcheckbox(
      {required bool value,
      required String name,
      required String address,
      required String pincode}) {
    _ischecked = value;
    if (value) {
      _billingnamecontroller.text = name;
      _billingaddresscontroller.text = address;
      _billingdropdownvalue = _postaldropdownvalue;
      _billingpincodecontroller.text = pincode;
      update();
    } else {
      _billingnamecontroller.clear();
      _billingaddresscontroller.clear();
      _billingdropdownvalue = '';
      _billingpincodecontroller.clear();
      update();
    }
    update();
  }

  void getpostaldropdownvalue({required String value}) {
    _postaldropdownvalue = value;
    update();
  }

 
}
