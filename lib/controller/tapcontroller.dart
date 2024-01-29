import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

class GetxTapController extends GetxController {
  bool _isloading = true;

  bool get isloading => _isloading;

  void onwebviewcreated() {
    _isloading = true;
    update();
  }

  void onwebviewcreatedfinish() {
    _isloading = false;
    update();
  }
}
