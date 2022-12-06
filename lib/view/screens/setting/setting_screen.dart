import 'package:daily_meme_digest/main.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();

  // bool keyboardIsOpen = true;

  @override
  void initState() {
    super.initState();
    _firstName..text = 'Abram';
    _lastName..text = 'Press';
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = KeyboardVisibilityProvider.isKeyboardVisible(context);
    print('Keyboard is open >> $keyboardIsOpen');

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF2994A)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.logout_rounded,
                                        size: 10.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE3E3E3),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/profile.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Abram Press',
                            maxLines: 1,
                            style: poppinsMedium.copyWith(
                              fontSize: 14.sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'Active since Sept 2022',
                            maxLines: 1,
                            style: poppinsRegular.copyWith(
                              fontSize: 12.sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'abram.press97',
                            maxLines: 1,
                            style: poppinsRegular.copyWith(
                              fontSize: 12.sp,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'First Name',
                      style: poppinsRegular.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                    CustomField(
                      controller: _firstName,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Last Name',
                      style: poppinsRegular.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                    CustomField(
                      controller: _lastName,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Visibility(
                  visible: !keyboardIsOpen,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                            'Save Changes',
                            style: poppinsMedium.copyWith(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
