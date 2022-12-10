import 'package:daily_meme_digest/util/app_constants.dart';
import 'package:daily_meme_digest/util/images.dart';
import 'package:daily_meme_digest/util/routes.dart';
import 'package:daily_meme_digest/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:daily_meme_digest/di_container.dart' as di;

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  SharedPreferences _sharePref;
  @override
  void initState() {
    // TODO: implement initState
    _sharePref = di.sl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/header_menu.jpg',
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFF2994A)),
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
                      image:
                          (_sharePref.getString(AppConstants.PROFILE_PICTURE) !=
                                  null)
                              ? AssetImage(
                                  'assets/images/troll_face.png',
                                )
                              : NetworkImage(
                                  _sharePref
                                      .getString(AppConstants.PROFILE_PICTURE),
                                ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  (_sharePref.getString(AppConstants.NAME) != null)
                      ? _sharePref.getString(AppConstants.NAME)
                      : '-',
                  maxLines: 1,
                  style: poppinsMedium.copyWith(
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _sharePref.getString(AppConstants.USERNAME),
                  maxLines: 1,
                  style: poppinsRegular.copyWith(
                    fontSize: 12.sp,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            minLeadingWidth: 20.sp,
            leading: Icon(
              Icons.home_rounded,
              size: 18.sp,
            ),
            title: Text(
              'Home',
              style: poppinsRegular.copyWith(
                fontSize: 10.sp,
              ),
            ),
            onTap: () => {
              Navigator.of(context)
                  .popAndPushNamed(Routes.getDashboardRoute('home')),
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            minLeadingWidth: 20.sp,
            leading: Icon(
              Icons.emoji_emotions_outlined,
              size: 18.sp,
            ),
            title: Text(
              'My Creation',
              style: poppinsRegular.copyWith(
                fontSize: 10.sp,
              ),
            ),
            onTap: () => {
              Navigator.of(context)
                  .popAndPushNamed(Routes.getDashboardRoute('creation')),
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            minLeadingWidth: 20.sp,
            leading: Icon(
              Icons.leaderboard_outlined,
              size: 18.sp,
            ),
            title: Text(
              'Leaderboard',
              style: poppinsRegular.copyWith(
                fontSize: 10.sp,
              ),
            ),
            onTap: () => {
              Navigator.of(context)
                  .popAndPushNamed(Routes.getDashboardRoute('leaderboard')),
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            minLeadingWidth: 20.sp,
            leading: Icon(
              Icons.settings,
              size: 18.sp,
            ),
            title: Text(
              'Setting',
              style: poppinsRegular.copyWith(
                fontSize: 10.sp,
              ),
            ),
            onTap: () => {
              Navigator.of(context)
                  .popAndPushNamed(Routes.getDashboardRoute('setting')),
            },
          ),
        ],
      ),
    );
  }
}
