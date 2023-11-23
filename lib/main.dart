import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:loginapp/components.dart';
import 'package:loginapp/firebase_options.dart';


import 'src/controllers/auth_controller/auth_controller.dart';
import 'src/controllers/data_coltroller/data_controller.dart';
import 'src/views/screens/splash_screens/splash_screen.dart';

void main() async {
  // Get.put(AuthController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: baseScreenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) => GetMaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        initialBinding: InitializedBinding() ,
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        }),
        darkTheme: darkTheme,
        home:AnnotatedRegion<SystemUiOverlayStyle>(value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent), child: child!) ,
      ),
        child: SplashScreen() ,
    );
  }
}


class InitializedBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(DataController());
    // Get.put(AuthController());
  }

}



