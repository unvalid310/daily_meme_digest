import 'package:daily_meme_digest/provider/auth_provider.dart';
import 'package:daily_meme_digest/util/routes.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:daily_meme_digest/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = KeyboardVisibilityProvider.isKeyboardVisible(context);

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        body: Consumer<AuthProvider>(
          builder: (context, state, widget) {
            return Form(
              key: _formKey,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 60, 30, 30),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/troll_face.png',
                              width: 200,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Username',
                            style: poppinsMedium.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                          CustomField(
                            hintText: 'Enter Username',
                            controller: _usernameController,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Password',
                            style: poppinsMedium.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                          CustomField(
                            hintText: 'Enter Password',
                            isPassword: true,
                            isShowSuffixIcon: true,
                            controller: _passwordController,
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Visibility(
                      visible: !keyboardIsOpen,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFF4D88FF),
                                  ),
                                ),
                                child: Text(
                                  'Create Account',
                                  style: poppinsMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: Color(0xFF4D88FF),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.REGISTER_SCREEN);
                              },
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              highlightColor: Colors.transparent,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFF4D88FF),
                                ),
                                child: Text(
                                  'Sign In',
                                  style: poppinsMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                context.loaderOverlay.show();

                                if (_formKey.currentState.validate()) {
                                  state
                                      .login(_usernameController.text,
                                          _passwordController.text)
                                      .then(
                                    (value) {
                                      if (value.isSuccess) {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.getMainRoute(),
                                            (route) => false);
                                      } else {
                                        context.loaderOverlay.hide();
                                        showCustomSnackBar(
                                            value.message, context);
                                      }
                                    },
                                  );
                                } else {
                                  context.loaderOverlay.hide();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
