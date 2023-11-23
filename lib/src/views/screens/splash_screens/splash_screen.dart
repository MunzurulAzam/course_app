import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/components.dart';
import 'package:loginapp/src/controllers/auth_controller/auth_controller.dart';
import 'package:loginapp/src/controllers/data_coltroller/data_controller.dart';
import 'package:loginapp/src/controllers/screen_controllers/splash_screens_controller/splash_screens_controller.dart';
import 'package:loginapp/src/function/form_validation.dart';
import 'package:loginapp/src/views/screens/dashboard_screens/dashboard_screen.dart';
import 'package:loginapp/src/views/widgets/base_widgets/custom_animated_size_widget.dart';
import 'package:loginapp/src/views/widgets/others/custom_divided_bar.dart';
import 'package:loginapp/src/views/widgets/text_fields/custom_text_field1.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController _controller = Get.put(SplashScreenController());
  PageController pageController = PageController();
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.initApp());
  }

  Widget greetingChild() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: Text(
        _controller.greetingText.value,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget switchButton(String text, bool isEmail,) {
    return OnProcessButtonWidget(
      backgroundColor: Colors.transparent,
      borderRadius: BorderRadius.zero,
      margin: EdgeInsets.only(right: defaultPadding / 2),
      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
      onDone: (_) {
        _controller.isEmail.value = isEmail;
        _controller.email = "";
        pageController.animateToPage(_controller.isEmail.value ? 0 : 1,
            duration: Duration(milliseconds: defaultDuration.inMilliseconds ~/ 2), curve: Curves.linear);
        if(!_controller.isEmail.value){
          Get.snackbar('Notice', 'This Authentication Feature is Coming Soon ');
        }

      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
            child: Text(text),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomDividedBar(color: _controller.isEmail.value == isEmail ? Theme.of(context).colorScheme.primary : Colors.transparent),
          )
        ],
      ),
    );
  }

  Widget groupButton(String headingText, {onDone}) {
    return OnProcessButtonWidget(
      expanded: false,
      backgroundColor: Colors.transparent,
      onDone: onDone,
      contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 4),
      constraints: BoxConstraints(),
      child: Text(headingText),
      textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget divideBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: CustomDividedBar(
          margin: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
        )),
        Text(
          'or',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary, height: 1),
        ),
        Expanded(
            child: CustomDividedBar(
          margin: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
        ))
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SplashScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Obx(() {
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisAlignment: _controller.expendLogin.value ? MainAxisAlignment.end : MainAxisAlignment.center,
                    children: [
                      if (_controller.expendLogin.value)
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + defaultPadding,
                        ),
                      //----------------------------------------------------------------------------------------------------------for get greeting text
                      greetingChild(),
                      CustomAnimatedSize(
                        alignment: Alignment.topCenter,
                        widthFactor: 1,
                        child: !_controller.expendLogin.value
                            ? null
                            : Container(
                                padding: EdgeInsets.all(defaultPadding),
                                alignment: Alignment.bottomCenter,
                                width: double.infinity,
                                margin: EdgeInsets.only(top: defaultPadding),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(defaultPadding)),
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                child: Form(
                                    child: Container(
                                  constraints: BoxConstraints(maxWidth: maxBoxWidth),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: defaultPadding / 4,
                                      ),
                                      Text(
                                        _controller.isLogin.value ? 'LogIn' : 'SignUp',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(height: defaultPadding),
                                      //! -------------------------------------------------------------- Email or Phone Switch
                                      Row(
                                        children: [
                                          switchButton("Email", true),
                                          switchButton("Phone", false,),
                                        ],
                                      ),
                                      SizedBox(height: defaultPadding),
                                      //! ------------------------------------------------------------------ Email
                                      SizedBox(
                                        height: defaultBoxHeight,
                                        child: PageView(
                                          controller: pageController,
                                          scrollDirection: Axis.vertical,
                                          physics: const NeverScrollableScrollPhysics(),
                                          children: [
                                            CustomTextField1(
                                              keyboardType: TextInputType.emailAddress,
                                              hintText: "Enter your email",
                                              onChanged: (value) => _controller.emailController.text = value,
                                              validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
                                              svg:'lib/assets/icons/message_icon.svg' ,
                                            ),
                                            CustomTextField1(
                                              keyboardType: TextInputType.phone,
                                              hintText: "Enter your phone number",
                                                svg:'lib/assets/icons/phone_icon.svg',
                                              validator: (value) => _controller.isEmail.value ? null : phoneNumberValidation(_controller.email),
                                              onChanged: (value) => _controller.email = value, //todo need implementation
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: defaultPadding / 2),

                                      //! -------------------------------------------------------------- Password
                                      CustomTextField1(
                                        keyboardType: TextInputType.visiblePassword,
                                        hintText: "Enter your password",
                                        svg: "lib/assets/icons/lock_icon.svg",
                                        obscureText: true,
                                        validator: (value) => passwordValidation(_controller.password),
                                        onChanged: (value) => _controller.passwordController.text = value,
                                      ),
                                      SizedBox(height: defaultPadding),

                                      //! -------------------------------------------------------------- Login Button
                                      OnProcessButtonWidget(
                                        onTap: () async {
                                          if (_controller.isLogin.value) {
                                           await _authController.login(_controller.emailController.text, _controller.passwordController.text);
                                          } else {
                                            await _authController.register(_controller.emailController.text, _controller.passwordController.text);
                                          }
                                          return null;
                                        },
                                        child: Text(_controller.isLogin.value ? "Login" : "Sign up"),
                                      ),
                                      SizedBox(height: defaultPadding / 4),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          groupButton('Forgot Password'),
                                          Text(
                                            '/',
                                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
                                          ),
                                          groupButton(_controller.isLogin.value ? 'Sign Up' : 'LogIn', onDone: (isDone) {
                                            _controller.toggleFormState();
                                          }), //todo work for signup
                                        ],
                                      ),
                                      SizedBox(
                                        height: defaultPadding / 2,
                                      ),

                                      divideBar(context),

                                      SizedBox(
                                        height: defaultPadding / 2,
                                      ),

                                      OnProcessButtonWidget(
                                          borderRadius: BorderRadius.circular(defaultPadding * 1000),
                                          backgroundColor: Colors.transparent,
                                          expanded: false,
                                          child: SvgPicture.asset('lib/assets/icons/google.svg'),
                                          onTap: () {
                                            _authController.signInWithGoogle();
                                            return null;
                                          }),
                                      SizedBox(
                                        height: MediaQuery.of(context).padding.bottom + defaultPadding,
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
