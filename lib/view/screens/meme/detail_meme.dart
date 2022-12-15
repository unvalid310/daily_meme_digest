// ignore_for_file: deprecated_member_use

import 'package:daily_meme_digest/data/model/response/comment_model.dart';
import 'package:daily_meme_digest/data/model/response/meme_model.dart';
import 'package:daily_meme_digest/provider/meme_provider.dart';
import 'package:daily_meme_digest/util/strings.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:daily_meme_digest/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DetailMeme extends StatefulWidget {
  final int postId;
  DetailMeme({@required this.postId});

  @override
  State<DetailMeme> createState() => _DetailMemeState();
}

class _DetailMemeState extends State<DetailMeme> {
  ScrollController _scrollController = ScrollController();
  int get postId => widget.postId;
  TextEditingController _commentController = TextEditingController();
  bool keyboardOpen = false;

  @override
  void initState() {
    Provider.of<MemeProvider>(context, listen: false)
        .getDetailPost(postId: postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Stack(
          overflow: Overflow.visible,
          clipBehavior: Clip.none,
          children: [
            Consumer<MemeProvider>(builder: (context, state, widget) {
              MemeModel meme;
              if (state.isLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
                meme = state.detailMeme;
              }
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: EdgeInsets.only(bottom: 95),
                child: (meme != null)
                    ? ListView(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/image_placeholder.png',
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                    image: meme.image,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              child: Icon(
                                                (meme.likeCount > 0)
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_rounded,
                                                color: (meme.likeCount > 0)
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 14.sp,
                                              ),
                                              onTap: () async {
                                                await Provider.of<MemeProvider>(
                                                  context,
                                                  listen: false,
                                                ).like(
                                                  {'post_id': meme.id},
                                                ).then(
                                                  (value) {
                                                    Provider.of<MemeProvider>(
                                                      context,
                                                      listen: false,
                                                    ).getDetailPost(
                                                        postId: postId,
                                                        refresh: true);
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(width: 10),
                                            (meme.likeCount != 0)
                                                ? Text(
                                                    meme.likeCount.toString(),
                                                    style:
                                                        poppinsRegular.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(width: 10),
                                            (meme.visitorCount != 0)
                                                ? Text(
                                                    'Dilihat ${meme.visitorCount.toString()}',
                                                    style:
                                                        poppinsRegular.copyWith(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mode_comment_rounded,
                                              color: Colors.blue[300],
                                              size: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (meme.like.length > 0 &&
                                    meme.like.length == 1)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                                    child: Text(
                                      meme.like[0].username,
                                      style: poppinsMedium.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                if (meme.like.length > 1)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                                    child: RichText(
                                      text: TextSpan(
                                          text: meme.like[0].username,
                                          style: poppinsMedium.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            for (var i = 1;
                                                i < meme.like.length;
                                                i++)
                                              TextSpan(
                                                text: ', ' +
                                                    meme.like[1].username,
                                                style: poppinsMedium.copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              )
                                          ]),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            child: ListView.separated(
                              controller: _scrollController,
                              itemCount: meme.comment.length,
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 20),
                              itemBuilder: (BuildContext context, int index) {
                                CommentModel _comment = meme.comment[index];

                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _comment.name,
                                              style: poppinsMedium.copyWith(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            getFormattedDate(
                                              DateTime.parse(_comment.date),
                                            ),
                                            style: poppinsMedium.copyWith(
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        _comment.comment,
                                        style: poppinsRegular.copyWith(
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child: Icon(
                                              (_comment.likeCount > 0)
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_rounded,
                                              color: (_comment.likeCount > 0)
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 14.sp,
                                            ),
                                            onTap: () async {
                                              await Provider.of<MemeProvider>(
                                                context,
                                                listen: false,
                                              ).commentLike(
                                                {'comment_id': _comment.id},
                                              ).then(
                                                (value) {
                                                  Provider.of<MemeProvider>(
                                                    context,
                                                    listen: false,
                                                  ).getDetailPost(
                                                    postId: postId,
                                                    refresh: true,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          (_comment.likeCount != 0)
                                              ? Text(
                                                  _comment.likeCount.toString(),
                                                  style:
                                                      poppinsRegular.copyWith(
                                                    fontSize: 10.sp,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : Container(),
              );
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Write Comment',
                      style: poppinsRegular.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomField(
                            hintText: 'Write Comment',
                            controller: _commentController,
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Icon(
                            Icons.send_rounded,
                            color: Colors.grey,
                          ),
                          onTap: () async {
                            if (_commentController.text.isEmpty) {
                              showCustomSnackBar('Komentar kosong!', context);
                            } else {
                              await Provider.of<MemeProvider>(context,
                                      listen: false)
                                  .comment(
                                {
                                  'post_id': postId,
                                  "comment": _commentController.text,
                                },
                              ).then((value) async {
                                if (value.isSuccess) {
                                  await Provider.of<MemeProvider>(context,
                                          listen: false)
                                      .getDetailPost(
                                          postId: postId, refresh: true)
                                      .then(
                                        (value) => _commentController.clear(),
                                      );
                                } else {
                                  showCustomSnackBar(value.message, context);
                                }
                              });
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
