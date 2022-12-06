import 'package:daily_meme_digest/data/model/response/leaderboard_model.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class LeaderboardScreen extends StatefulWidget {
  LeaderboardScreen({Key key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<LeaderboardModel> _listLeaderboard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listLeaderboard = [
      LeaderboardModel(1, 'assets/images/profile1.png', 'Jordyn Dokdis', 2100),
      LeaderboardModel(1, 'assets/images/profile2.png', 'Adison Calzoni', 2005),
      LeaderboardModel(1, 'assets/images/profile3.png', 'Makena Vetrovs', 1940),
      LeaderboardModel(1, 'assets/images/profile4.png', 'Mira Mango', 1890),
      LeaderboardModel(1, 'assets/images/profile.png', 'Abram Press', 1200),
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
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _listLeaderboard.length,
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemBuilder: (context, index) {
              LeaderboardModel _leaderBoard = _listLeaderboard[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 30,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE3E3E3),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        _leaderBoard.image,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  _leaderBoard.name,
                  maxLines: 1,
                  style: poppinsRegular.copyWith(
                    fontSize: 10.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 14.sp,
                      ),
                      SizedBox(width: 10),
                      Text(
                        _leaderBoard.like.toString(),
                        style: poppinsRegular.copyWith(
                          fontSize: 10.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
