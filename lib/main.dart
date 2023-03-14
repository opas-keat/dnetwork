import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/shared/page_not_found.dart';

final talker = Talker(
  /// Your own observers to handle errors's exception's and log's
  /// like Crashlytics or Sentry observer
  observers: [],
  settings: TalkerSettings(
    /// You can enable/disable all talker processes with this field
    enabled: !kReleaseMode,

    /// You can enable/disable saving logs data in history
    useHistory: true,

    /// Length of history that saving logs data
    maxHistoryItems: 100,

    /// You can enable/disable console logs
    useConsoleLogs: true,
  ),

  /// Setup your implementation of logger
  logger: TalkerLogger(),

  ///etc...
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      title: "d-network",
      // localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // supportedLocales: const [
      //   Locale('th', 'TH'),
      // ],
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: "/not-found",
        page: () => const PageNotFound(),
        transition: Transition.noTransition,
      ),
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.sarabunTextTheme(),
        // primaryColor: primaryColor,
        // primaryColorDark: primaryLightColor,
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   secondary: accentColor,
        // ),
        // appBarTheme: const AppBarTheme(
        //   iconTheme: IconThemeData(color: Colors.black),
        //   color: primaryColor,
        // ),
      ),
    );
  }
}
