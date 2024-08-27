import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/src/core/routes/pages.dart';
import 'package:tic_tac_toe/src/core/translate/strings.dart';
import 'package:loader_overlay/loader_overlay.dart';

// ignore: depend_on_referenced_packages
import "package:flutter_localizations/flutter_localizations.dart";

import 'src/core/common/theme.dart';
import 'src/core/data/preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Preferences _preferences = Preferences();

  @override
  void initState() {
    if (Get.theme.brightness == Brightness.dark) {
      /// Validar el tema del usuario posteriormente
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      );
    } else {
      /// Validar el tema del usuario posteriormente
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        return Center(
          child:
              Lottie.asset("assets/anims/loader.json", width: 80, height: 80),
        );
      },
      child: GetMaterialApp(
        getPages: AppPages.getApplicacionRoutes(),
        debugShowCheckedModeBanner: false,
        translations: Strings(),
        locale: const Locale("es"),
        // locale: Locale(_preferences.language),
        themeMode: themeMode(_preferences.themeModeApp),
        theme: MaterialTheme().light(),
        darkTheme: MaterialTheme().dark(),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: const <Locale>[
          Locale("es", "ES"),
          // Locale("en", "EN"),
        ],
      ),
    );
  }
}
