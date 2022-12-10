import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:daily_meme_digest/helper/router_helper.dart';
import 'package:daily_meme_digest/localization/app_localization.dart';
import 'package:daily_meme_digest/provider/auth_provider.dart';
import 'package:daily_meme_digest/util/routes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'di_container.dart' as di;
import 'provider/language_provider.dart';
import 'provider/localization_provider.dart';
import 'provider/theme_provider.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'util/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<LocalizationProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initalRoutes;

  @override
  void initState() {
    super.initState();
    initalRoutes = Routes.LOGIN_SCREEN;

    RouterHelper.setupRouter();
    // checking();
  }

  // Future<void> checking() async {
  //   // melakukan pengecekan status login
  //   if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
  //     setState(() {
  //       initalRoutes = Routes.HOME_SCREEN;
  //     });
  //   } else {
  //     setState(() {
  //       initalRoutes = Routes.LOGIN_SCREEN;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });

    return Sizer(
      builder: (context, orientation, deviceType) {
        return KeyboardVisibilityProvider(
          child: MaterialApp(
            initialRoute: initalRoutes,
            onGenerateRoute: RouterHelper.router.generator,
            title: 'Daily Memes Digest App',
            navigatorKey: MyApp.navigatorKey,
            theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
            locale: Provider.of<LocalizationProvider>(context).locale,
            localizationsDelegates: [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: _locals,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
