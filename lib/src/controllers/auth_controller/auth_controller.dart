import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginapp/src/views/screens/dashboard_screens/dashboard_screen.dart';
import 'package:loginapp/src/views/screens/splash_screens/splash_screen.dart';


class AuthController extends GetxController{

  static AuthController instance = Get.find();

  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  GoogleSignIn googleSign = GoogleSignIn();


  late Rx<User?> firebaseUser;

  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() async{
    super.onReady();


    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);


    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);


    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {

      // ------------------------------------------------------------------------------ user is not found then navigated to the Register Screen
      Get.offAll(() => const SplashScreen());

    } else {

      // --------------------------------------------------------------------------------- user exists and logged in then navigated to the Home Screen
      Get.offAll(() => DashboardScreen());

    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // ----------------------------------------------------------------------------- user is not found then  navigated to the Register Screen
      Get.offAll(() =>  SplashScreen());
    } else {
      // ----------------------------------------------------------------------------- user is not found then  navigated to the Dashboard Screen
      Get.offAll(() =>  DashboardScreen());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
      print(e.toString());
    }
  }

  Future <void> register(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // -------------------------------------------------------------------Check registration was successful
      if (userCredential.user != null) {
        // --------------------------------------------------------------Registration successful, navigate to DashboardScreen
        Get.offAll(() => const DashboardScreen());
      } else {
        //---------------------------------------------------------------- Registration failed
      }
    } catch (e) {
      // ---------------------------------------------------------------------Handle registration errors
      Get.snackbar(
        "Registration Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
      print(e.toString());
    }
  }

  //------------------------------------------------------------------------------------for Logout

 Future <void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar('Log in Error', firebaseAuthException.toString() );
    }
  }

  void signOut() async {
    await auth.signOut();
  }


}