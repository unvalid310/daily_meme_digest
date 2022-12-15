// ignore_for_file: must_be_immutable

import 'package:daily_meme_digest/data/model/response/meme_model.dart';
import 'package:daily_meme_digest/provider/meme_provider.dart';
import 'package:daily_meme_digest/util/app_constants.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/screens/meme/create_meme.dart';
import 'package:daily_meme_digest/view/screens/meme/detail_meme.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:daily_meme_digest/di_container.dart' as di;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  SharedPreferences serPref = di.sl();
  List<MemeModel> _memList = [];
  int _filterId;
  String _filterName;
  @override
  void initState() {
    _filterId = 0;
    _filterName = 'Newest';
    Provider.of<MemeProvider>(context, listen: false)
        .getMeme(filter: _filterId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayOpacity: 0,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        body: Consumer<MemeProvider>(
          builder: (context, state, widget) {
            if (state.isLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
              _memList = state.memeList;
            }

            return ListView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Text(
                          _filterName.toString(),
                          style: poppinsMedium.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Icon(
                            Icons.filter_alt_rounded,
                            size: 14.sp,
                          ),
                        ),
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Wrap(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _filterId = 1;
                                          _filterName = 'Hottest';
                                        });
                                        Navigator.pop(context, 'true');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        width: double.infinity,
                                        child: Text(
                                          'Hottest',
                                          style: poppinsMedium.copyWith(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _filterId = 2;
                                          _filterName = 'Most Interaction';
                                        });
                                        Navigator.pop(context, 'true');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        width: double.infinity,
                                        child: Text(
                                          'Most Interaction',
                                          style: poppinsMedium.copyWith(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _filterId = 3;
                                          _filterName = 'Most Viewed';
                                        });
                                        Navigator.pop(context, 'true');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        width: double.infinity,
                                        child: Text(
                                          'Most Viewed',
                                          style: poppinsMedium.copyWith(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).then((value) {
                            if (value != null) {
                              Provider.of<MemeProvider>(context, listen: false)
                                  .getMeme(filter: _filterId.toString());
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                (_memList.length != null)
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: ListView.separated(
                          itemCount: _memList.length,
                          controller: _scrollController,
                          shrinkWrap: true,
                          clipBehavior: Clip.none,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 20),
                          itemBuilder: (BuildContext context, int index) {
                            MemeModel _meme = _memList[index];

                            return Container(
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
                                children: [
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DetailMeme(postId: _meme.id),
                                        ),
                                      ).then(
                                        (value) => Provider.of<MemeProvider>(
                                                context,
                                                listen: false)
                                            .getMeme(
                                          filter: _filterId.toString(),
                                          refresh: true,
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/image_placeholder.png',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                        image: _meme.image,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                child: Icon(
                                                  (_meme.likeCount > 0)
                                                      ? Icons.favorite
                                                      : Icons
                                                          .favorite_border_rounded,
                                                  color: (_meme.likeCount > 0)
                                                      ? Colors.red
                                                      : Colors.grey,
                                                  size: 14.sp,
                                                ),
                                                onTap: () async {
                                                  await Provider.of<
                                                      MemeProvider>(
                                                    context,
                                                    listen: false,
                                                  ).like(
                                                    {'post_id': _meme.id},
                                                  ).then(
                                                    (value) {
                                                      Provider.of<MemeProvider>(
                                                        context,
                                                        listen: false,
                                                      ).getMeme(
                                                          filter: _filterId
                                                              .toString(),
                                                          refresh: true);
                                                    },
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 10),
                                              (_meme.likeCount != 0)
                                                  ? Text(
                                                      _meme.likeCount
                                                          .toString(),
                                                      style: poppinsRegular
                                                          .copyWith(
                                                        fontSize: 10.sp,
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                              SizedBox(width: 10),
                                              (_meme.visitorCount != 0)
                                                  ? Text(
                                                      'Dilihat ${_meme.visitorCount.toString()}',
                                                      style: poppinsRegular
                                                          .copyWith(
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
                                  if (_meme.like.length > 0 &&
                                      _meme.like.length == 1)
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 15),
                                      child: Text(
                                        _meme.like[0].username,
                                        style: poppinsMedium.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  if (_meme.like.length > 1)
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 15),
                                      child: RichText(
                                        text: TextSpan(
                                            text: _meme.like[0].username,
                                            style: poppinsMedium.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              for (var i = 1;
                                                  i < _meme.like.length;
                                                  i++)
                                                TextSpan(
                                                  text: ', ' +
                                                      _meme.like[1].username,
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
                            );
                          },
                        ),
                      )
                    : Container(
                        color: Colors.white,
                      ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateMeme(),
              ),
            ).then(
              (value) =>
                  Provider.of<MemeProvider>(context, listen: false).getMeme(
                filter: _filterId.toString(),
                refresh: true,
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
