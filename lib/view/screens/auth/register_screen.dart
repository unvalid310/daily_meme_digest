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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: Text(''),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, state, widget) {
            return Form(
              key: _formKey,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Daily Meme Digest',
                              style: poppinsMedium.copyWith(
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Create Account',
                              style: poppinsRegular.copyWith(
                                fontSize: 14.sp,
                              ),
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
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Repeat Password',
                            style: poppinsMedium.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                          CustomField(
                            hintText: 'Repeat Password',
                            isPassword: true,
                            isShowSuffixIcon: true,
                            controller: _repeatPasswordController,
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Visibility(
                      visible: !keyboardIsOpen,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            width: double.infinity,
                            child: InkWell(
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
                                  'Create Account',
                                  style: poppinsMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                context.loaderOverlay.show();

                                if (_formKey.currentState.validate()) {
                                  if (_passwordController.text !=
                                      _repeatPasswordController.text) {
                                    context.loaderOverlay.hide();
                                    showCustomSnackBar(
                                        'Password tidak sama', context);
                                  } else {
                                    Map<String, dynamic> data = {
                                      "username": _usernameController.text,
                                      "password": _passwordController.text,
                                    };
                                    await Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .registration(data)
                                        .then(
                                      (value) {
                                        if (value.isSuccess) {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Routes.LOGIN_SCREEN,
                                              (route) => false);
                                        } else {
                                          context.loaderOverlay.hide();
                                          showCustomSnackBar(
                                              value.message, context);
                                        }
                                      },
                                    );
                                  }
                                } else {
                                  context.loaderOverlay.hide();
                                }
                              },
                            ),
                          ),
                        ],
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
