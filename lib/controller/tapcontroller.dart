import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:atompaymentdemo/constant/constant.dart';
import 'package:atompaymentdemo/controller/atom_pay_helper.dart';
import 'package:atompaymentdemo/model/departmentmodel.dart';
import 'package:atompaymentdemo/model/gazettedetails.dart';
import 'package:atompaymentdemo/model/searchmodel.dart';
import 'package:atompaymentdemo/pages/searchpage.dart';
import 'package:atompaymentdemo/router/router.gr.dart';
import 'package:atompaymentdemo/sevices/localnotification.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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

   final DataPagerController dataPagerController = DataPagerController( );
  

  String _transacid = '';
  String get transacid => _transacid;

  String transactiondate = '';
  String transactiontime = '';

  final List<String> _alldepartmentlist = [];
  List<String> get alldepartmentlist => _alldepartmentlist;

  List<Employee> get employee => _employees;
  //DateField

  //BILLING  ADRRESS
  final TextEditingController _billingnamecontroller = TextEditingController();
  final TextEditingController _billingaddresscontroller =
      TextEditingController();
  final TextEditingController _billingpincodecontroller =
      TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();

  final TextEditingController _emailcontroller = TextEditingController();

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

  bool _istextexpanded = false;
  bool get istextexpanded => _istextexpanded;

  bool _isfiltersearch = false;
  bool get isfiltersearch => _isfiltersearch;

  bool _ispaymentinfosend = true;
  bool get ispaymentinfosend => _ispaymentinfosend;

  //
  String searchtextvalue = '';

  String _billingdropdownvalue = '';
  String _postaldropdownvalue = '';

  String get billingdropdownvalue => _billingdropdownvalue;
  String get postaldropdownvalue => _postaldropdownvalue;

   int?  _gazettid;
  int ?get gazettid => _gazettid;

      int  _paginationindex = 0;
  int get paginationindex => _paginationindex;

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
  TextEditingController get mobilecontroller => _mobilecontroller;
  TextEditingController get emailcontroller => _emailcontroller;

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

  bool? _isdownloadedfile;
  bool? get isdownloadedfile => _isdownloadedfile;

  bool _ispaymentprocessstarted = false;
  bool get ispaymentprocessstarted => _ispaymentprocessstarted;
  @override
  Future<void> onInit() async {
    super.onInit();
       Future.delayed(const Duration(seconds: 1))
        .whenComplete(() => FlutterNativeSplash.remove());
    gettodaydate();

   
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

  checktextexpanded({required bool isexpanded}){
    log(isexpanded.toString());
    _istextexpanded = !isexpanded;
    update();
    log(_istextexpanded.toString());
  }

  resetdata() {
    _isserverok = true;
   _isfiltersearch = false;
   
    _employees.clear();
    _ispaymentprocessstarted = false;

    isDataLoading(true);
    _ischecked = false;

    _billingaddresscontroller.clear();
    _billingdropdownvalue = '';
    _billingnamecontroller.clear();
    _billingpincodecontroller.clear();
    _isdataempty = false;

    update();
  }

  //getSearchData

  Future getsearchdata({required String value}) async {
    searchtextvalue = value;

    resetdata();

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
          update();
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
    _employees.clear();
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
          
_isfiltersearch = true;
update();
          // ignore: use_build_context_synchronously

        }else{
        _isfiltersearch = false;
        
        update();
      
        }
          _allsearchdata = users;

        update();
        log('users$users');
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

//getGaZette Details

  Future getGazetteDetails({
    required String titlename,
  }) async {
    isDataLoading(true);
  for (var element in _allsearchdata) {
                 if( element.title==titlename){
                  var index=_allsearchdata.indexOf(element);
_gazettid = _allsearchdata[index].gazetteId;
update();
                 }  
                   }
    try {
      final response = await http.get(
        Uri.parse('http://10.10.1.139:8099/api/gazettes/$_gazettid'),
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
       DateTime date = DateTime(_allsearchdata[i].publicationdate.year, _allsearchdata[i].publicationdate.month, _allsearchdata[i].publicationdate.day);
 
      _employees.add(Employee(
          // gazettenumber: _allsearchdata[i].gazetteId,
          title: _allsearchdata[i].title,
          // totalpage: _allsearchdata[i].totalpages,
          publidate: '${date.day}/${date.month}/${date.year}'));
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

  updatepage({required int index}){
        _paginationindex = index;
    update();
  }
  handlepagination(){
    dataPagerController.selectedPageIndex = _paginationindex;
    update();

    log( dataPagerController.selectedPageIndex.toString());
  
  }

  Future<bool> handlePageChange(int newPageIndex) async {
_paginationindex = newPageIndex;
update();
   
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
      required String mobile,
      required String email,
      required String address,
      required String pincode}) {
    _ischecked = value;
    if (value) {
      _billingnamecontroller.text = name;
      _billingaddresscontroller.text = address;
      _billingdropdownvalue = _postaldropdownvalue;
      _billingpincodecontroller.text = pincode;
      _mobilecontroller.text = mobile;
      _emailcontroller.text = email;
      update();
    } else {
      _billingnamecontroller.clear();
      _billingaddresscontroller.clear();
      _billingdropdownvalue = '';
      _billingpincodecontroller.clear();
      _mobilecontroller.clear();
      _emailcontroller.clear();
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
  final String login = "317159"; //"445842"; //mandatory
  final String password = 'Test@123'; //mandatory
  final String prodid = 'NSE'; //mandatory
  final String requestHashKey = 'KEY123657234'; //mandatory
  final String responseHashKey = 'KEYRESP123657234'; //mandatory
  final String requestEncryptionKey =
      'A4476C2062FFA58980DC8F79EB6A799E'; //mandatory
  final String responseDecryptionKey =
      '75AEF0FA1B94B3C10D4F5B268F757F11'; //mandatory
  // final String txnid =
  //     'test240223'; // mandatory // this should be unique each time
  final String clientcode = "NAVIN"; //mandatory
  final String txncurr = "INR"; //mandatory
  final String mccCode = "5499"; //mandatory
  final String merchType = "R"; //mandatory
  // final String amount = "1.00"; //mandatory

  final String mode = "uat"; // change live for production

  // final String custFirstName = 'test'; //optional
  // final String custLastName = 'user'; //optional
  // final String mobile = '8888888888'; //optional
  // final String email = 'test@gmail.com'; //optional
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
    _ispaymentprocessstarted = true;
    update();
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
                '{"atomTokenId" : "$atomTokenId","merchId": "$login","emailId": "${_emailcontroller.text}","mobileNumber":"${_mobilecontroller.text}", "returnUrl":"$returnUrl"}';
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
    context.router
        .push(PaymentPage(
            mode: mode,
            payDetails: payDetails,
            responsehashKey: responseHashKey,
            responseDecryptionKey: responseDecryptionKey))
        .whenComplete(() {
      _ispaymentprocessstarted = false;
      update();
    });
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
    payDetails['mobile'] = _mobilecontroller.text;
    payDetails['address'] = address;
    payDetails['email'] = _emailcontroller.text;
    payDetails['txnid'] = _transacid;
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

  void sendpaymentinfo({
    required int gazetteId,
    required String postalname,
    required String fulladdress,
    required String pincode,
    required int totalprice,
    required String enteredby,
    required String remark,
  }) async {
    gettransactionid();
    log('1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
    try {
      final response = await http.post(
          Uri.parse('http://10.10.1.139:8099/api/Billings/MakePayment'),
          headers: {
            'Content-Type': 'application/json', // Set the Content-Type header
          },
          body: jsonEncode(
            {
              "gazetteId": gazetteId,
              "fullname": postalname,
              "fulladdress": fulladdress,
              "district": _postaldropdownvalue,
              "pincode": pincode,
              "totalprice": totalprice,
              "namebill": _billingnamecontroller.text,
              "addressbill": _billingaddresscontroller.text,
              "districtbill": _billingdropdownvalue,
              "pincodebill": _billingpincodecontroller.text,
              "enteredby": enteredby,
              "remark": remark,
              "transactionid": _transacid
            },
          ));

      if (response.statusCode == 200) {
        log('Done Post Successfully');
      } else {
        print('Failedrerer to Getdata.');
        //  _isserverok = false;
      }
      return null;
    } catch (e) {
      // _isserverok = false;

      log('init log $e');
    }
  }

  // updatepaymentremark({
  //   required String transactionid,
  //   required String remark,
  // }) async {
  //   try {
  //     final queryParameters = {"transacid": transactionid};
  //     final response = await http.put(
  //       Uri.http(
  //           '10.10.1.139:8099', '/Billings/UpdatePayment', queryParameters), headers: {
  //       'Content-Type': 'application/json', // Set the Content-Type header
  //     },
  //       body: jsonEncode({
  //         "remark": remark,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       log('Done updated Successfully');
  //     } else {
  //       print('Failedrerer to Getdata.');
  //       //  _isserverok = false;
  //     }
  //     return null;
  //   } catch (e) {
  //     // _isserverok = false;

  //     print(e.toString());
  //   }
  // }
  updatepaymentremark({
    required String transactionid,
    required String remark,
  }) async {
    _isdownloadedfile = null;
    update();

    try {
      final queryParameters = {"transacid": transactionid};
      final response = await http.put(
        Uri.http(
          '10.10.1.139:8099', // host and port
          '/api/Billings/UpdatePayment', // path
          queryParameters, // query parameters
        ),
        headers: {
          'Content-Type': 'application/json', // Set the Content-Type header
        },
        body: jsonEncode({
          "remark": remark,
        }),
      );

      if (response.statusCode == 200) {
        print('Done updated Successfully');
        var date = DateTime.now();

        transactiondate = DateFormat('dd/MM/yyyy').add_jm().format(date);

        log(transactiondate);

        update();
      } else {
        _ispaymentinfosend = false;
        update();
        print('Failed to update data.');
      }
    } catch (e) {
      _ispaymentinfosend = false;
      update();
      print(e.toString());
    }
  }

  /// GENERATE RANDOM TRANSACTION ID

  void gettransactionid() {
    String generateRandomString(int length) {
      const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      final random = math.Random();
      return List.generate(
              length, (index) => characters[random.nextInt(characters.length)])
          .join();
    }

    _transacid = generateRandomString(10);
    update();
    print(_transacid);
  }

  Downloadfile({required String trnxid}) async {
    _isdownloadedfile = false;
    update();

    try {
      final queryParameters = {"transacId": trnxid};
      final response = await http.get(
        Uri.http(
          '10.10.1.139:8099', // host and port
          '/api/gazettes/download', // path
          queryParameters, // query parameters
        ),
      );

      if (response.statusCode == 200) {
        const filePath = 'storage/emulated/0/Download/gazette_file.pdf';

        // Write the file to the document directory
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes).then((value) {
          NotificationService().showDownloadNotification(payLoad: value.path);
        });

        print('File downloaded to: $filePath');

        _isdownloadedfile = true;
        // ignore: use_build_context_synchronously
        update();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Downloaded File Successfully')));
      } else {
        _isdownloadedfile = null;
        update();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Download Fail Check Network')));
        print('Failedrerer to Getdata.');
        //  _isserverok = false;
      }
      return null;
    } catch (e) {
      _isdownloadedfile = null;
      update();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Download Fail Newtwork Error')));
      // _isserverok = false;

      print(e.toString());
    }
  }
  checkdownloadpath()async{
      String downloadFolderPath = await getDownloadDirectoryPath();
  log('Download folder path: $downloadFolderPath');
  }

  getDownloadfile({required String trnxid}) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final status = android.version.sdkInt < 30
        ? await Permission.storage.request()
        :  await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("Storage permission granted");
      Downloadfile(trnxid: trnxid);
    } else if (status.isDenied) {
      print("Storage permission denied");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error Storage Permission Denied')));
    } else if (status.isPermanentlyDenied) {
      print("Storage permission permanently denied");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error Storage Permission Denied permanently')));
      // Consider showing a dialog or opening the app settings to enable the permission
    }
  }

  getDownloadReciept(
      {required String paymentname, required String amount}) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
log('Android SDK Version :${android.version.sdkInt}');
  final status = android.version.sdkInt < 30
        ? await Permission.storage.request()
        :  await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("Storage permission granted");

      final imageFile =
          await getImageFileFromAssets('assets/images/reciept.png');
      final image = pw.MemoryImage(File(imageFile.path).readAsBytesSync());
      final pdf = pw.Document();

      // Add your desired widget to the PDF
      pdf.addPage(pw.Page(
        build: (pw.Context context2) {
          log('dsdsdsnew');
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Image(image, height: 150),
                pw.SizedBox(
                  height: 30,
                ),
                pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 45),
                    child: pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        width: MediaQuery.of(context).size.width,
                        padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                        child: pw.Column(
                          children: [
                            pw.Text(
                              'Payment Reciept',
                              style: pw.TextStyle(
                                fontSize: 26,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 20),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'Payee Name: ',
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                                pw.Text(
                                  _billingnamecontroller.text,
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'Amount Paid: ',
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                                pw.Text(
                                  amount,
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'Transaction ID:',
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                                pw.Text(
                                  _transacid,
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'Payment Method: ',
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                                pw.Text(
                                  paymentname,
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'Transaction Date: ',
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                                pw.Text(
                                  transactiondate,
                                  style:  const pw.TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 10),
                          ],
                        )))
              ],
            ),
          );
        },
      ));


      // Save the PDF to a file
      const filePath = 'storage/emulated/0/Download/paymentreciept.pdf';
      final file = File(filePath);

      await file.writeAsBytes(await pdf.save()).then((value) {
        NotificationService().showDownloadNotification(payLoad: value.path);
      });
    } else if (status.isDenied) {
      print("Storage permission denied");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error Storage Permission Denied')));
    } else if (status.isPermanentlyDenied) {
      print("Storage permission permanently denied");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error Storage Permission Denied permanently')));
      // Consider showing a dialog or opening the app settings to enable the permission
    }
  }


Future<String> getDownloadDirectoryPath() async {
  Directory? externalDir = await getExternalStorageDirectory();
  if (externalDir != null) {
    return '${externalDir.path}/Download';
  } else {
    throw 'Could not access external storage directory';
  }
}
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final tempFile = File('${(await getTemporaryDirectory()).path}/$path');
    await tempFile.create(recursive: true);
    await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

    return tempFile;
  }
}
