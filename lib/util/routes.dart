class Routes {
  static const String LOGIN_SCREEN = '/login';
  static const String REGISTER_SCREEN = '/register';
  static const String DASHBOARD = '/';
  static const String DASHBOARD_SCREEN = '/main';

  static String getLoginRoute() => LOGIN_SCREEN;
  static String getRegisterRoute() => REGISTER_SCREEN;
  static String getMainRoute() => DASHBOARD;
  static String getDashboardRoute(String page) =>
      '$DASHBOARD_SCREEN?page=$page';
}
