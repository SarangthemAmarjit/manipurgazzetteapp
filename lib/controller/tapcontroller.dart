import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:atompaymentdemo/constant/constant.dart';
import 'package:atompaymentdemo/controller/atom_pay_helper.dart';
import 'package:atompaymentdemo/model/departmentmodel.dart';
import 'package:atompaymentdemo/model/gazettedetails.dart';
import 'package:atompaymentdemo/model/searchmodel.dart';
import 'package:atompaymentdemo/pages/searchpage.dart';
import 'package:atompaymentdemo/router/router.gr.dart';

import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String? get validationError => _validationError;

  String? _errortitletext;
  String? get errortitletext => _errortitletext;

  String? _errorgazettetype;
  String? get errorgazettetype => _errorgazettetype;

  final List<String> _alldepartmentlist = [];
  List<String> get alldepartmentlist => _alldepartmentlist;

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

  //Gazette Details
  GazetteDetails? _gazettedetails;
  GazetteDetails get gazettedetails => _gazettedetails!;

  //Server Error
  bool _isserverok = true;
  bool get isserverok => _isserverok;

  //
  String searchtextvalue = '';

  String _billingdropdownvalue = '';
  String _postaldropdownvalue = '';

  String get billingdropdownvalue => _billingdropdownvalue;
  String get postaldropdownvalue => _postaldropdownvalue;

  bool _isloading = true;
  bool _isdataempty = false;

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

  //Department
  List<AllDepartment> _alldepartment = [];
  List<AllDepartment> get alldepartment => _alldepartment;
  //
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

  //
  bool _isfocusontextfield = false;
  bool get isfocusontextfield => _isfocusontextfield;

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

  void validatetitle(String value) {
    if (value.isEmpty) {
      _errortitletext = 'Title is required';
      log('Empty');
      update();
    } else {
      _errortitletext = null;
      update();
    }
  }

  void validategazette(String value) {
    if (value.isEmpty) {
      _errortitletext = 'Please select the Gazette Type';
      update();
    } else {
      _errortitletext = null;
      update();
    }
  }

  void onfocuschange({required bool value, required String searchtext}) {
    _isfocusontextfield = value;
    update();
    if (_isfocusontextfield == false) {
      if (searchtext.isEmpty) {
        _validationError = null;
        update();
      }
    }
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

      if (response.statusCode == 200) {
        var users = allSearchResultDataFromJson(response.body);
        if (users.isEmpty) {
          isDataLoading(false);
          _isdataempty = true;
          // ignore: use_build_context_synchronously
          showDialog(
            context: (context),
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Search Result'),
                content: const Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('No Record Found'),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      context.router
                          .pop()
                          .whenComplete(() => context.router.pop());
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        _allsearchdata = users;

        update();

        getEmployeeData();
        isDataLoading(false);
      } else {
        print('Failedrerer to Getdata.');
        isDataLoading(false);
        _isserverok = false;
        update();
      }
      return null;
    } catch (e) {
      isDataLoading(false);
      _isserverok = false;
      update();

      print(e.toString());
    }
  }

//getFilterData

  Future getFilterData({
    required String title,
    required String gazettetype,
    required String category,
    required int? deptid,
  }) async {
    isDataLoading(true);

    try {
      final queryParameters = {
        "title": title,
        "gazettetype": gazettetype,
        "startDate": _publishfromcontroller.text,
        "endDate": _publishtillcontroller.text,
        "category": category,
        "departmentid": deptid ?? '',
      };
      final response = await http.get(
        Uri.http('10.10.1.139:8099', '/api/gazettes/search', queryParameters),
      );

      if (response.statusCode == 200) {
        var users = allSearchResultDataFromJson(response.body);
        if (users.isEmpty) {
          isDataLoading(false);
          _isdataempty = true;
          // ignore: use_build_context_synchronously
          showDialog(
            context: (context),
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Search Result'),
                content: const Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('No Record Found'),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      context.router
                          .pop()
                          .whenComplete(() => context.router.pop());
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        _allsearchdata = users;

        update();
        log('users$users');

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

//getGaZette Details

  Future getGazetteDetails({
    required int gazetteid,
  }) async {
    isDataLoading(true);

    try {
      final response = await http.get(
        Uri.parse('http://10.10.1.96/api/gazettes/$gazetteid'),
      );

      if (response.statusCode == 200) {
        var users = gazetteDetailsFromJson(response.body);

        _gazettedetails = users;
        log(users.title.toString());

        update();

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

  getDeapartment() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.10.1.139:8099/api/Departments'),
      );

      if (response.statusCode == 200) {
        var users = allDepartmentFromJson(response.body);

        _alldepartment = users;

        for (var element in _alldepartment) {
          if (_alldepartmentlist.contains(element.name)) {
          } else {
            _alldepartmentlist.add(element.name);
          }
        }
        update();
        log('users$users');
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

  Future<bool> handlePageChange(int newPageIndex) async {
    int startIndex = newPageIndex * 15;
    int endIndex = startIndex + 15;
    log('pageindex ${newPageIndex.toString()}');

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

  // P A Y M E N T   GATEWAY

  // merchant configuration data
  final String login = "445842"; //mandatory
  final String password = 'Test@123'; //mandatory
  final String prodid = 'NSE'; //mandatory
  final String requestHashKey = 'KEY123657234'; //mandatory
  final String responseHashKey = 'KEYRESP123657234'; //mandatory
  final String requestEncryptionKey =
      'A4476C2062FFA58980DC8F79EB6A799E'; //mandatory
  final String responseDecryptionKey =
      '75AEF0FA1B94B3C10D4F5B268F757F11'; //mandatory
  final String txnid =
      'test240223'; // mandatory // this should be unique each time
  final String clientcode = "NAVIN"; //mandatory
  final String txncurr = "INR"; //mandatory
  final String mccCode = "5499"; //mandatory
  final String merchType = "R"; //mandatory
  // final String amount = "1.00"; //mandatory

  final String mode = "uat"; // change live for production

  // final String custFirstName = 'test'; //optional
  // final String custLastName = 'user'; //optional
  final String mobile = '8888888888'; //optional
  final String email = 'test@gmail.com'; //optional
  // final String address = 'mumbai'; //optional
  final String custacc = '639827'; //optional
  final String udf1 = "udf1"; //optional
  final String udf2 = "udf2"; //optional
  final String udf3 = "udf3"; //optional
  final String udf4 = "udf4"; //optional
  final String udf5 = "udf5"; //optional

  final String authApiUrl = "https://caller.atomtech.in/ots/aipay/auth"; // uat

  // final String auth_API_url =
  //     "https://payment1.atomtech.in/ots/aipay/auth"; // prod

  final String returnUrl =
      "https://pgtest.atomtech.in/mobilesdk/param"; //return url uat
  // final String returnUrl =
  //     "https://payment.atomtech.in/mobilesdk/param"; ////return url production

  final String payDetails = '';

  void initNdpsPayment(
      {required BuildContext context,
      required String responseHashKey,
      required String responseDecryptionKey,
      required String name,
      required String amount,
      required String address}) {
    _getEncryptedPayUrl(
        context: context,
        responseHashKey: responseHashKey,
        responseDecryptionKey: responseDecryptionKey,
        name: name,
        amount: amount,
        address: address);
  }

  _getEncryptedPayUrl(
      {required BuildContext context,
      required String responseHashKey,
      required String responseDecryptionKey,
      required String name,
      required String amount,
      required String address}) async {
    String reqJsonData =
        _getJsonPayloadData(name: name, amount: amount, address: address);
    debugPrint(reqJsonData);
    const platform = MethodChannel('flutter.dev/NDPSAESLibrary');
    try {
      final String result = await platform.invokeMethod('NDPSAESInit', {
        'AES_Method': 'encrypt',
        'text': reqJsonData, // plain text for encryption
        'encKey': requestEncryptionKey // encryption key
      });
      String authEncryptedString = result.toString();
      // here is result.toString() parameter you will receive encrypted string
      // debugPrint("generated encrypted string: '$authEncryptedString'");
      _getAtomTokenId(context, authEncryptedString);
    } on PlatformException catch (e) {
      debugPrint("Failed to get encryption string: '${e.message}'.");
    }
  }

  _getAtomTokenId(context, authEncryptedString) async {
    var request = http.Request(
        'POST', Uri.parse("https://caller.atomtech.in/ots/aipay/auth"));
    request.bodyFields = {'encData': authEncryptedString, 'merchId': login};

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      log('200');
      var authApiResponse = await response.stream.bytesToString();
      final split = authApiResponse.trim().split('&');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };
      final splitTwo = values[1]!.split('=');
      if (splitTwo[0] == 'encData') {
        const platform = MethodChannel('flutter.dev/NDPSAESLibrary');
        try {
          final String result = await platform.invokeMethod('NDPSAESInit', {
            'AES_Method': 'decrypt',
            'text': splitTwo[1].toString(),
            'encKey': responseDecryptionKey
          });
          debugPrint(result.toString()); // to read full response
          var respJsonStr = result.toString();
          Map<String, dynamic> jsonInput = jsonDecode(respJsonStr);
          if (jsonInput["responseDetails"]["txnStatusCode"] == 'OTS0000') {
            final atomTokenId = jsonInput["atomTokenId"].toString();
            debugPrint("atomTokenId: $atomTokenId");
            final String payDetails =
                '{"atomTokenId" : "$atomTokenId","merchId": "$login","emailId": "$email","mobileNumber":"$mobile", "returnUrl":"$returnUrl"}';
            _openNdpsPG(
                payDetails, context, responseHashKey, responseDecryptionKey);
          } else {
            debugPrint("Problem in auth API response");
          }
        } on PlatformException catch (e) {
          debugPrint("Failed to decrypt: '${e.message}'.");
        }
      }
    }
  }

  _openNdpsPG(payDetails, BuildContext context, responseHashKey,
      responseDecryptionKey) {
    context.router.push(PaymentPage(
        mode: mode,
        payDetails: payDetails,
        responsehashKey: responseHashKey,
        responseDecryptionKey: responseDecryptionKey));
  }

  _getJsonPayloadData(
      {required String name, required String amount, required String address}) {
    var payDetails = {};
    payDetails['login'] = login;
    payDetails['password'] = password;
    payDetails['prodid'] = prodid;
    payDetails['custFirstName'] = name;
    payDetails['custLastName'] = '';
    payDetails['amount'] = amount;
    payDetails['mobile'] = mobile;
    payDetails['address'] = address;
    payDetails['email'] = email;
    payDetails['txnid'] = txnid;
    payDetails['custacc'] = custacc;
    payDetails['requestHashKey'] = requestHashKey;
    payDetails['responseHashKey'] = responseHashKey;
    payDetails['requestencryptionKey'] = requestEncryptionKey;
    payDetails['responseencypritonKey'] = responseDecryptionKey;
    payDetails['clientcode'] = clientcode;
    payDetails['txncurr'] = txncurr;
    payDetails['mccCode'] = mccCode;
    payDetails['merchType'] = merchType;
    payDetails['returnUrl'] = returnUrl;
    payDetails['mode'] = mode;
    payDetails['udf1'] = udf1;
    payDetails['udf2'] = udf2;
    payDetails['udf3'] = udf3;
    payDetails['udf4'] = udf4;
    payDetails['udf5'] = udf5;
    String jsonPayLoadData = getRequestJsonData(payDetails);
    return jsonPayLoadData;
  }
}
