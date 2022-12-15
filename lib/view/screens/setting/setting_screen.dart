import 'dart:io';

import 'package:daily_meme_digest/data/model/response/user_model.dart';
import 'package:daily_meme_digest/main.dart';
import 'package:daily_meme_digest/provider/auth_provider.dart';
import 'package:daily_meme_digest/provider/profile_provider.dart';
import 'package:daily_meme_digest/util/app_constants.dart';
import 'package:daily_meme_digest/util/routes.dart';
import 'package:daily_meme_digest/util/strings.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:daily_meme_digest/view/base/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:daily_meme_digest/di_container.dart' as di;

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ScrollController _scrollController = ScrollController();
  SharedPreferences sharePref = di.sl();

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();

  UserModel userModel;
  final picker = ImagePicker();
  File _image;
  bool private;

  @override
  void initState() {
    super.initState();
    userModel = null;
    private =
        (sharePref.getString(AppConstants.PRIVATE) != null) ? true : false;
    loadData();
  }

  loadData() async {
    await Provider.of<ProfileProvider>(context, listen: false)
        .getProfile()
        .then((value) {
      setState(() {
        userModel = value;
        _firstName.text = userModel.firstName;
        _lastName.text = userModel.lastName;
      });
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
        resizeToAvoidBottomInset: false,
        body: Consumer<ProfileProvider>(
          builder: (context, state, widget) {
            if (state.isLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            return (userModel != null)
                ? Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false)
                                                  .logout()
                                                  .then(
                                                (value) {
                                                  if (value) {
                                                    return Navigator
                                                        .pushNamedAndRemoveUntil(
                                                      context,
                                                      Routes.LOGIN_SCREEN,
                                                      (route) => false,
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFFF2994A)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                    InkWell(
                                      onTap: () async {
                                        getImage();
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFE3E3E3),
                                          border: Border.all(
                                              color: Colors.grey[200]),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: (_image != null)
                                                ? FileImage(_image)
                                                : (userModel.image != null)
                                                    ? NetworkImage(
                                                        userModel.image)
                                                    : AssetImage(
                                                        'assets/images/default_profile.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      (userModel.name != null)
                                          ? (private)
                                              ? (userModel.name.length > 3)
                                                  ? userModel.name.substring(
                                                          0,
                                                          userModel
                                                                  .name.length -
                                                              (userModel.name
                                                                      .length -
                                                                  3)) +
                                                      userModel.name
                                                          .substring(3)
                                                          .replaceAll(
                                                              RegExp(r"."), "*")
                                                  : userModel.name
                                              : userModel.name
                                          : '-',
                                      maxLines: 1,
                                      style: poppinsMedium.copyWith(
                                        fontSize: 14.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      'Active since ${getCustomDateFormat(DateTime.parse(userModel.createdAt), 'MMM yyyy')}',
                                      maxLines: 1,
                                      style: poppinsRegular.copyWith(
                                        fontSize: 12.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      userModel.username,
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
                                inputAction: TextInputAction.done,
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
                                inputAction: TextInputAction.done,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Checkbox(
                                    value: private,
                                    onChanged: (value) {
                                      print('check box >> $value');
                                      sharePref.remove(AppConstants.PRIVATE);
                                      setState(() {
                                        private = value;
                                      });
                                      if (value) {
                                        sharePref.setString(
                                            AppConstants.PRIVATE, 'private');
                                      }
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      sharePref.remove(AppConstants.PRIVATE);
                                      if (private) {
                                        setState(() {
                                          private = false;
                                        });
                                      } else {
                                        setState(() {
                                          private = true;
                                        });
                                        sharePref.setString(
                                            AppConstants.PRIVATE, 'private');
                                      }
                                    },
                                    child: Text(
                                      'Hide my name',
                                      style: poppinsMedium.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  )
                                ],
                              )
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
                                  onTap: () async {
                                    String _filename;
                                    if (_image != null) {
                                      _filename = _image.path.split('/').last;
                                    }

                                    FormData data = FormData.fromMap(
                                      {
                                        'first_name': _firstName.text,
                                        'last_name': _lastName.text,
                                        'file': (_image != null)
                                            ? await MultipartFile.fromFile(
                                                _image.path,
                                                filename: _filename,
                                              )
                                            : null
                                      },
                                    );

                                    await Provider.of<ProfileProvider>(context,
                                            listen: false)
                                        .updateProfile(data)
                                        .then((value) {
                                      if (value.isSuccess) {
                                        loadData();
                                      } else {
                                        showCustomSnackBar(
                                            value.message, context);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }
}
