import 'package:daily_meme_digest/util/styles.dart';
import 'package:daily_meme_digest/view/screens/creation/creation_screen.dart';
import 'package:daily_meme_digest/view/screens/home/home_screen.dart';
import 'package:daily_meme_digest/view/screens/leaderboard/leaderboard_screen.dart';
import 'package:daily_meme_digest/view/screens/menu/menu_screen.dart';
import 'package:daily_meme_digest/view/screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      CreationScreen(),
      LeaderboardScreen(),
      SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        drawer: MenuScreen(),
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: Text(
            'Daily Meme Digest',
            style: poppinsMedium.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Color(0xFFA0A4A8),
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.home_rounded, 'Home', 0),
            _barItem(Icons.emoji_emotions_outlined, 'My Creation', 1),
            _barItem(Icons.leaderboard_outlined, 'Leaderboard', 2),
            _barItem(Icons.settings, 'Setting', 3),
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            color: index == _pageIndex
                ? Theme.of(context).primaryColor
                : Color(0xFFA0A4A8),
            size: 25,
          ),
        ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
