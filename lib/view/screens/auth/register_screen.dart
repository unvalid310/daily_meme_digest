import 'package:daily_meme_digest/util/routes.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _repeatPasswordController =
        TextEditingController();

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

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
        body: Stack(
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
                      onTap: () {},
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.LOGIN_SCREEN, (route) => false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
