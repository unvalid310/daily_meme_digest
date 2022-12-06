import 'package:daily_meme_digest/data/model/response/comment_model.dart';
import 'package:daily_meme_digest/data/model/response/meme_model.dart';
import 'package:daily_meme_digest/util/strings.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/base/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class DetailMeme extends StatefulWidget {
  final MemeModel meme;
  DetailMeme({Key key, @required this.meme}) : super(key: key);

  @override
  State<DetailMeme> createState() => _DetailMemeState();
}

class _DetailMemeState extends State<DetailMeme> {
  ScrollController _scrollController = ScrollController();

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
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView(
                controller: _scrollController,
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
                            image: widget.meme.image,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.meme.like.toString(),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.mode_comment_rounded,
                                      color: Colors.blue[300],
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.meme.comment.length.toString(),
                                      style: poppinsRegular.copyWith(
                                        fontSize: 10.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: widget.meme.comment.length,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 20),
                      itemBuilder: (BuildContext context, int index) {
                        CommentModel _comment = widget.meme.comment[index];
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
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
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Icon(
                            Icons.send_rounded,
                            color: Colors.grey,
                          ),
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
