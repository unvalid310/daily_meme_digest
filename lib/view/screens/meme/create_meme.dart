import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart';

class CreateMeme extends StatefulWidget {
  CreateMeme({Key key}) : super(key: key);

  @override
  State<CreateMeme> createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> {
  ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  File _image;
  TextEditingController _imgUrl = TextEditingController();
  TextEditingController _topText = TextEditingController();
  TextEditingController _bottomText = TextEditingController();
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
                          ? Stack(
                              children: [
                                Image.file(
                                  _image,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
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
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
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
                            )
                          : FadeInImage(
                              placeholder: AssetImage(
                                  'assets/images/image_placeholder.png'),
                              height: MediaQuery.of(context).size.height * 0.3,
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
                          FocusScope.of(context).nextFocus();
                          if (_imgUrl.text.isNotEmpty) {
                            await urlToFile(_imgUrl.text).then(
                              (file) => setState(() {
                                _image = file;
                              }),
                            );
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
      ),
    );
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath/img');

    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List uint8list = response.bodyBytes;
    ByteBuffer buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    await file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}
