import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//! ------------------------------------------------------------------------------------------------  Information
const baseName = "Welcome";
const projectName = "Learning";

//! ------------------------------------------------------------------------------------------------ Sizes
const baseScreenSize = Size(360, 800);
final defaultPadding = 24.sp;
final defaultBoxHeight = defaultPadding * 2;
const paginationPageSize = 10;
final maxBoxWidth = 400.sp;

//* Border
double borderWidth1 = 2.sp;
double borderWidth2 = 1.sp;

//! ------------------------------------------------------------------------------------------------ Time
const defaultSplashScreenShow = 3;
const defaultDuration = Duration(milliseconds: 500);
const apiCallTimeOut = Duration(seconds: 20);

//! ------------------------------------------------------------------------------------------------ Color
const _primaryLight = Color(0xff1aa7ec);
//! ------------------------------------------------------------------------------------------------ Text
final textTheme = GoogleFonts.montserratTextTheme(Typography.englishLike2018.apply(fontSizeFactor: 1.sp));

//! ------------------------------------------------------------------------------------------------ Theme
final lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  colorScheme: ColorScheme.fromSeed(seedColor: _primaryLight, brightness: Brightness.light),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  colorScheme: ColorScheme.fromSeed(seedColor: _primaryLight, brightness: Brightness.dark),
);

//! ------------------------------------------------------------------------------------------------ Validation
const int phoneNumberLength = 11;
const int nameMinLength = 8;
const int passwordMinLength = 8;
const String emailValidationPattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
const int otpValidationLength = 4;