import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:loginapp/src/models/app_models/page_model.dart';

class DashboardScreenController extends GetxController{

  final List<PageModel> dropDownList = [
    PageModel(pageHeading: "Logout", svg: "lib/assets/icons/logout.svg", page: const SizedBox())
  ];
}