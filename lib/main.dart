import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'app/shared/constant.dart';
import 'app/shared/page_not_found.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('th', 'TH'),
      ],
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', 'US'), // English
      //   Locale('th', 'TH'), // Thai
      // ],
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: "/not-found",
        page: () => const PageNotFound(),
        transition: Transition.noTransition,
      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData.light().copyWith(
        // dropdownMenuTheme: DropdownMenuThemeData(inputDecorationTheme: InputDecorationTheme(),textStyle: TextStyle()),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        drawerTheme: const DrawerThemeData(
            scrimColor: Colors.transparent, elevation: 0.5),
        // dropdownMenuTheme: const DropdownMenuThemeData(
        //   textStyle: TextStyle(
        //     fontSize: 12,
        //   ),
        // ),
        textTheme: GoogleFonts.sarabunTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black87),
        canvasColor: canvasColor,
        scrollbarTheme: ScrollbarThemeData(
          trackVisibility: MaterialStateProperty.all(false),
          thumbVisibility: MaterialStateProperty.all(true),
          thumbColor: MaterialStateProperty.all<Color>(Colors.black26),
        ),
      ),
    );
  }
}
