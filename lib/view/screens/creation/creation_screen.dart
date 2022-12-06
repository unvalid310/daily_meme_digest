import 'package:daily_meme_digest/data/model/response/comment_model.dart';
import 'package:daily_meme_digest/data/model/response/meme_model.dart';
import 'package:daily_meme_digest/util/strings.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/screens/meme/detail_meme.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class CreationScreen extends StatefulWidget {
  CreationScreen({Key key}) : super(key: key);

  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {
  ScrollController _scrollController = ScrollController();
  List<MemeModel> _memList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _memList = [
      MemeModel(
        1,
        'https://i.imgflip.com/714tbk.jpg',
        '2022-12-06 08:00:00',
        200,
        [
          CommentModel(1, 'Kadin Dias', '2022-11-03', 'LoL! Hillarious'),
          CommentModel(1, 'Corey Franci', '2022-11-03',
              'Your house also turn into dust. Files win!'),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView.separated(
            itemCount: _memList.length,
            controller: _scrollController,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 20),
            itemBuilder: (BuildContext context, int index) {
              MemeModel _meme = _memList[index];

              return InkWell(
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMeme(meme: _meme),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/image_placeholder.png',
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          image: _meme.image,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getCustomDateFormat(DateTime.parse(_meme.date),
                                  'd MMMM yyyy hh:mm'),
                              style: poppinsRegular.copyWith(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 14.sp,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        _meme.like.toString(),
                                        style: poppinsRegular.copyWith(
                                          fontSize: 10.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.mode_comment_rounded,
                                        color: Colors.blue[300],
                                        size: 14.sp,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        _meme.comment.length.toString(),
                                        style: poppinsRegular.copyWith(
                                          fontSize: 10.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
