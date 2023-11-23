import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginapp/components.dart';
import 'package:loginapp/src/controllers/data_coltroller/data_controller.dart';

class SplashScreenController extends GetxController {
  final DataController _controller = Get.find();
  final RxBool isInit = false.obs;
  final RxBool isSplashScreenDone = false.obs;
  RxBool isEmail = true.obs;
  RxBool expendLogin = false.obs;
  RxBool isLogin = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxString greetingText = baseName.obs;
  String email = "";
  String password = "";

  void initApp() {
    _controller.initApp().then((_) {
      isInit.value = true;
      //todo call function for go back log in screen
      gotoHome();
    });
    Future.delayed(const Duration(seconds: defaultSplashScreenShow)).then((_) {
      isSplashScreenDone.value = true;
      gotoHome();
    });
  }

  gotoHome() {
    //todo need implementation  for  login information
    expendLogin.value = true;
    greetingText.value = "Welcome to $projectName";
  }

  void toggleFormState() {
    isLogin.value = !isLogin.value;
  }
}
