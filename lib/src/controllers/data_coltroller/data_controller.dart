import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginapp/firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tuple/tuple.dart';

import '../auth_controller/auth_controller.dart';

class DataController extends GetxController{
  bool _isInit = false;
  final Rx<PackageInfo?> packageInfo = Rxn();

  //------------------------------------------------------------ Initializing App (All init task will be execute here)

  Future<void> initApp() async {
    if(_isInit) return;


    packageInfo.value = await PackageInfo.fromPlatform();



  }

}