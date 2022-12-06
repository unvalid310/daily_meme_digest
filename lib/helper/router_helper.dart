import 'package:daily_meme_digest/view/screens/auth/register_screen.dart';
import 'package:daily_meme_digest/view/screens/dashboard/dashboard_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:daily_meme_digest/util/routes.dart';
import 'package:daily_meme_digest/view/screens/auth/login_screen.dart';
import 'package:daily_meme_digest/view/screens/home/home_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static Handler _loginHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static Handler _registerHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => RegisterScreen());
  static Handler _dashScreenBoardHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => DashboardScreen(
      pageIndex: params['page'][0] == 'home'
          ? 0
          : params['page'][0] == 'creation'
              ? 1
              : params['page'][0] == 'leaderboard'
                  ? 2
                  : params['page'][0] == 'setting'
                      ? 3
                      : 0,
    ),
  );
  static Handler _deshboardHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          DashboardScreen(pageIndex: 0));

  static void setupRouter() {
    router.define(Routes.REGISTER_SCREEN,
        handler: _registerHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LOGIN_SCREEN,
        handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DASHBOARD_SCREEN,
        handler: _dashScreenBoardHandler,
        transitionType: TransitionType.fadeIn); // ?page=home
    router.define(Routes.DASHBOARD,
        handler: _deshboardHandler, transitionType: TransitionType.fadeIn);
  }
}
