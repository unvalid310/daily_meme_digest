import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:daily_meme_digest/provider/meme_provider.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:daily_meme_digest/view/base/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart';
import 'dart:ui' as ui;

class CreateMeme extends StatefulWidget {
  CreateMeme({Key key}) : super(key: key);

  @override
  State<CreateMeme> createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> {
  ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey globalKey = new GlobalKey();

  TextEditingController _imgUrl = TextEditingController();
  TextEditingController _topText = TextEditingController();
  TextEditingController _bottomText = TextEditingController();

  File _image;
  Random rng = new Random();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text(
            'Meme Detail',
            style: poppinsMedium.copyWith(fontSize: 14.sp),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preview',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 10),
                        (_image != null)
                            ? RepaintBoundary(
                                key: globalKey,
                                child: Stack(
                                  children: [
                                    Image.file(
                                      _image,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              _topText.text.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: poppinsBold.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 26.sp,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 3.0,
                                                    color: Colors.black87,
                                                  ),
                                                  Shadow(
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 8.0,
                                                    color: Colors.black87,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8),
                                              child: Text(
                                                _bottomText.text.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: poppinsBold.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 26.sp,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(2.0, 2.0),
                                                      blurRadius: 3.0,
                                                      color: Colors.black87,
                                                    ),
                                                    Shadow(
                                                      offset: Offset(2.0, 2.0),
                                                      blurRadius: 8.0,
                                                      color: Colors.black87,
                                                    ),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : FadeInImage(
                                placeholder: AssetImage(
                                    'assets/images/image_placeholder.png'),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/image_placeholder.png'),
                              ),
                        SizedBox(height: 20),
                        Text(
                          'Image URL',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        CustomField(
                          controller: _imgUrl,
                          onEditingComplete: () async {
                            print('editing complete');
                            if (_imgUrl.text.isNotEmpty) {
                              await urlToFile(_imgUrl.text).then((file) {
                                setState(() {
                                  _image = file;
                                });

                                FocusScope.of(context).nextFocus();
                              });
                            }
                          },
                          onChanged: (value) async {
                            if (value != null) {
                              print('on change');
                              if (_imgUrl.text.isNotEmpty) {
                                await urlToFile(_imgUrl.text).then((file) {
                                  setState(() {
                                    _image = file;
                                  });
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Top Text',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        CustomField(
                          controller: _topText,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Bottom Text',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        CustomField(
                          controller: _bottomText,
                        ),
                        SizedBox(height: 20),
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
                              'Submit',
                              style: poppinsMedium.copyWith(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              if (_imgUrl != null) {
                                postMeme(context);
                              } else {
                                showCustomSnackBar('Gambar tidak ada', context);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future postMeme(BuildContext context) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();

    ui.Image image = await boundary.toImage();

    final directory = (await getApplicationDocumentsDirectory()).path;

    ByteData byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    Uint8List pngBytes = byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );

    File imgFile = new File('$directory/screenshot${rng.nextInt(200)}.png');

    await imgFile.writeAsBytes(pngBytes);
    print('path >> ${imgFile.path}');

    await Provider.of<MemeProvider>(context, listen: false)
        .postMeme(imgFile)
        .then(
      (value) {
        if (value.isSuccess) {
          Navigator.pop(context);
        } else {
          showCustomSnackBar(value.message, context);
        }
      },
    );
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath/img-${rng.nextInt(200)}.png');

    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List uint8list = response.bodyBytes;
    ByteBuffer buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    await file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
